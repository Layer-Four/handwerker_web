import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

import '../../../constants/api/api.dart';
import '../../../models/customer_models/customer_short_model/customer_short_dm.dart';
import '../../../models/project_models/project_entry_dm/project_entry_dm.dart';
import '../../../models/project_models/project_entry_vm/project_entry_vm.dart';
import '../../../models/project_models/projects_state_enum/project_state.dart';

final projectVMProvider = ChangeNotifierProvider<ProjectVMNotifier>((ref) => ProjectVMNotifier());

class ProjectVMNotifier extends ChangeNotifier {
  // Attributes of Notifier
  final Logger _log = Logger('ProjectVMProvider');
  final Api _api = Api();
  ProjectEntryVM? _editableProject;
  List<ProjectEntryDM> _projects = [];
  List<ProjectEntryVM> _projectVms = [];
  bool _isLoading = false;
  final List<CustomerShortDM> _customer = [];
// Getter
  List<ProjectEntryVM> get projects => _projectVms;
  List<CustomerShortDM> get customers => _customer;
  bool get isLoading => _isLoading;
  ProjectEntryVM? get editAbleProject => _editableProject;

  ProjectVMNotifier() {
    loadProjects();
  }

  void clearEditableProject() {
    _editableProject = null;
    _log.info(_editableProject?.toJson().toString());
  }

  void initLoad() => _isLoading = true;
  void endLoad() => _isLoading = false;

  Future<bool> createProject() async {
    if (_editableProject == null || !_editableProject!.isProjectMinFilled()) {
      return false;
    }
    final json = ProjectEntryDM(
      title: _editableProject!.title,
      dateOfStart: _editableProject!.start.toIso8601String(),
      dateOfTermination: _editableProject!.terminationDate.toIso8601String(),
      description: _editableProject!.description,
      projectStatusId: _editableProject!.state.value,
      customerId: _editableProject!.customer!.id,
    ).toJson();
    try {
      final response = await _api.postCreateProjectEntry(json);
      if (response.statusCode != 200) {
        _log.warning('call to DB has success but BE send ${response.statusCode}');
        throw Exception(
          'Error on createProject, status-> ${response.statusCode}\n ${response.data}',
        );
      }
      loadProjects();
      return true;
    } on DioException catch (e) {
      _log.warning('Failed to create project DB access failed: ${e.response!.statusCode}');
    } catch (e) {
      _log.warning('Failed to create project: $e');
    }
    return false;
  }

  Future<bool> deleteProject(ProjectEntryVM project) async {
    _log.info('start deleteProject');
    try {
      final response = await _api.delDeleteProjectEntry(project.id!);
      if (response.statusCode != 200) {
        throw Exception(
          'deleteProject dismissed-> status: ${response.statusCode}\n${response.data}',
        );
      }
      loadProjects();
      return true;
    } on DioException catch (e) {
      _log.warning('Failed to delete project: ${e.response?.statusCode}\n${e.response?.data}');
    } catch (e) {
      _log.warning('Failed to delete project: $e');
      _log.severe('Error deleting project: $e');
    }
    return false;
  }

  Future<void> fetchCustomer() async {
    try {
      final response = await _api.getListCustomer;
      if (response.statusCode != 200) {
        _log.warning('Failed to update project: ${response.statusCode}');
        throw Exception(
          'fetchCustomer dismissed-> status: ${response.statusCode}\n${response.data}',
        );
      }
      final List<dynamic> data = response.data;
      final result = data.map((json) => CustomerShortDM.fromJson(json)).toList();
      _customer.clear();
      _customer.addAll(result);
      return;
    } on DioException catch (e) {
      _log.warning('Failed to fetch Customer DioException: ${e.response!.statusCode}');
    } catch (e) {
      _log.warning('Error loading projects: $e');
      // Handle the error appropriately
    }
    return;
  }

  void loadProjects() async {
    _log.info('${_log.name} start load projects JSON');
    if (_customer.isEmpty) await fetchCustomer();

    final List<ProjectEntryVM> result = [];
    _isLoading = true;
    notifyListeners();
    try {
      final response = await _api.getAllProjects; // Correctly call the getter
      if (response.statusCode != 200) {
        _log.warning('ProjectVMProvider Request dismissed: status code ${response.statusCode}');
        _isLoading = false;
        notifyListeners();
        return;
      }
      final List data = response.data;
      _projects = data.map<ProjectEntryDM>((e) => ProjectEntryDM.fromJson(e)).toList();
      for (var e in _projects) {
        final customer = _customer.firstWhere(
          (j) => j.id == e.customerId,
          orElse: () => CustomerShortDM(id: 0, companyName: 'Hab die ID überschrieben'),
        );
        result.add(
          ProjectEntryVM(
              title: e.title ?? 'Kein Name vergeben',
              start: DateTime.parse(e.dateOfStart ?? DateTime.now().toIso8601String()),
              terminationDate:
                  DateTime.parse(e.dateOfTermination ?? DateTime.now().toIso8601String()),
              state: e.projectStatusId != null
                  ? ProjectState.values.firstWhere((k) => e.projectStatusId == k.value)
                  : ProjectState.planning,
              description: e.description,
              customer: customer,
              id: e.id),
        );
      }
      _projectVms = result;
      notifyListeners();
      return;
    } catch (e) {
      _log.severe('Error loading projects: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void updateEditableEntry({
    CustomerShortDM? newCustomer,
    String? newDescription,
    DateTime? newStart,
    ProjectState? newState,
    DateTime? newTermination,
    String? newTitle,
    int? newID,
  }) {
    _editableProject = _editableProject == null
        ? ProjectEntryVM(
            customer: newCustomer,
            description: newDescription,
            start: newStart ?? DateTime.now(),
            state: newState ?? ProjectState.planning,
            terminationDate: newTermination ?? DateTime.now(),
            title: newTitle ?? '',
            id: newID,
          )
        : _editableProject!.copyWith(
            customer: newCustomer ?? _editableProject!.customer,
            description: newDescription ?? _editableProject!.description,
            start: newStart ?? _editableProject!.start,
            state: newState ?? _editableProject!.state,
            terminationDate: newTermination ?? _editableProject!.terminationDate,
            title: newTitle ?? _editableProject!.title,
            id: newID ?? _editableProject!.id,
          );
    _log.info(_editableProject!.toJson().toString());
    notifyListeners();
    return;
  }

  Future<bool> updateProject() async {
    _log.info('start updateProject');
    if (_editableProject != null && _editableProject!.isProjectMinFilled()) {
      final json = ProjectEntryDM(
        title: _editableProject!.title,
        dateOfStart: _editableProject!.start.toIso8601String(),
        dateOfTermination: _editableProject!.terminationDate.toIso8601String(),
        description: _editableProject!.description,
        id: _editableProject!.id,
        projectStatusId: _editableProject!.state.value,
        customerId: _editableProject!.customer!.id,
      ).toJson();
      try {
        // Update API call to include project ID
        final response = await _api.putUpdateProjectEntry(json);
        if (response.statusCode != 200) {
          _log.warning('Failed to update project: ${response.statusCode}');
          throw Exception(
            'updateProject dismissed-> status: ${response.statusCode}\n${response.data}',
          );
        }
        loadProjects(); // Make sure this reloads the projects list after update
        return true;
      } on DioException catch (e) {
        _log.severe(
            'DioException updating project: ${e.response?.statusCode} \n${e.response?.data}');
      } catch (e) {
        _log.severe('Error updating project: $e');
      }
    }
    return false;
  }
}
