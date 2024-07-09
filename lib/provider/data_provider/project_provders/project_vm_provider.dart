import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

import '../../../constants/api/api.dart';
import '../../../models/consumable_models/customer_overview_dm/customer_overvew_dm.dart';
import '../../../models/customer_models/customer_short_model/customer_short_dm.dart';
import '../../../models/project_models/project_entry_dm/project_entry_dm.dart';
import '../../../models/project_models/project_entry_vm/project_entry_vm.dart';
import '../../customer_provider/customer_provider.dart';

int count = 0;
final projectVMProvider = ChangeNotifierProvider<ProjectVMProvider>((ref) {
  count++;
  if (ref.watch(customerProvider).isEmpty) {
    log(('leer $count'));
    ref.read(customerProvider.notifier).loadAllCustomers().then(
          (e) => ProjectVMProvider(ref.watch(customerProvider)),
        );
  }
  log(('voll $count'));
  return ProjectVMProvider(ref.watch(customerProvider));
});

class ProjectVMProvider extends ChangeNotifier {
  final Logger _log = Logger('ProjectVMProvider');
  final Api _api = Api();
  List<ProjectEntryDM> _projects = [];
  List<ProjectEntryVM> _projectVms = [];
  bool _isLoading = false;
  final List<CustomerOvervewDM> _customer;

  List<ProjectEntryDM> get projects => _projects;
  List<ProjectEntryVM> get projectVms => _projectVms;
  List<CustomerShortDM> get customers {
    final result = <CustomerShortDM>[];
    for (var e in _customer) {
      result.add(
        CustomerShortDM(
          id: e.customerID!,
          companyName: e.customerCredentials.companyName!,
        ),
      );
    }
    return result;
  }

  bool get isLoading => _isLoading;

  ProjectVMProvider(this._customer) {
    loadProjects();
  }

  void loadProjects() async {
    _log.info('${_log.name} start load projects JSON');
    if (_customer.isEmpty) return;

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
        final customer = _customer.firstWhere((j) => j.customerID == e.customerId);
        if (e.projectStatusId != null) {
          _log.info(ProjectState.values.firstWhere((k) => e.projectStatusId == k.value));
        }
        result.add(
          ProjectEntryVM(
            title: e.title ?? 'Kein Name vergeben',
            start: DateTime.parse(e.dateOfStart ?? DateTime.now().toIso8601String()),
            terminationDate: DateTime.parse(e.dateOfTermination!),
            state: e.projectStatusId != null
                ? ProjectState.values.firstWhere((k) => e.projectStatusId == k.value)
                : ProjectState.onHold,
            description: e.description,
            customer: CustomerShortDM(
              id: customer.customerID!,
              companyName: customer.customerCredentials.companyName!,
            ),
          ),
        );
      }
      log('$result');
      _projectVms = result;
      return;
    } catch (e) {
      _log.severe('Error loading projects: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<List<CustomerShortDM>> fetchCustomer() async {
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
      return result;
    } on DioException catch (e) {
      _log.warning('Failed to fetch Customer DioException: ${e.response!.statusCode}');
    } catch (e) {
      _log.warning('Error loading projects: $e');
      _log.warning('Error loading projects: $e');
      // Handle the error appropriately
    }
    return [];
  }

  void updateProject(int? projectId, ProjectEntryDM updatedProject) async {
    _log.info('start updateProject');
    try {
      final response = await _api.putUpdateProjectEntry({
        'projectId': projectId,
        ...updatedProject.toJson(),
      }); // Update API call to include project ID
      if (response.statusCode != 200) {
        _log.warning('Failed to update project: ${response.statusCode}');
        return;
      }
      loadProjects(); // Make sure this reloads the projects list after update
    } catch (e) {
      _log.severe('Error updating project: $e');
    }
  }

  Future<bool> deleteProject(int projectId) async {
    _log.info('start deleteProject');
    try {
      final response = await _api.delDeleteProjectEntry(projectId);
      if (response.statusCode != 200) {
        throw Exception(
          'deleteProject dismissed-> status: ${response.statusCode}\n${response.data}',
        );
      }
      loadProjects();
      return true;
    } on DioException catch (e) {
      _log.warning('Failed to delete project: ${e.response!.statusCode}');
    } catch (e) {
      _log.warning('Failed to delete project: $e');
      _log.severe('Error deleting project: $e');
    }
    return false;
  }
}
