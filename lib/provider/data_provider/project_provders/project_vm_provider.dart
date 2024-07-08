import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

import '../../../constants/api/api.dart';
import '../../../models/project_entry_models/project_entry_vm/project_entry_vm.dart';

class ProjectVMProvider extends ChangeNotifier {
  final Logger _log = Logger('ProjectVMProvider');
  final Api _api;
  List<ProjectEntryVM> _projects = [];
  bool _isLoading = false;

  List<ProjectEntryVM> get projects => _projects;
  bool get isLoading => _isLoading;

  ProjectVMProvider(this._api) {
    loadProjects();
  }

  void loadProjects() async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await _api.getAllProjects; // Correctly call the getter
      if (response.statusCode != 200) {
        if (response.statusCode == 401) {
          _log.warning('Request dismissed: unauthorized');
          _isLoading = false;
          notifyListeners();
          return;
        }
        _log.warning('Request dismissed: status code ${response.statusCode}');
        _isLoading = false;
        notifyListeners();
        return;
      }
      final List data = response.data;
      _projects = data.map<ProjectEntryVM>((e) => ProjectEntryVM.fromJson(e)).toList();
    } catch (e) {
      _log.severe('Error loading projects: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void updateProject(int? projectId, ProjectEntryVM updatedProject) async {
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

  void deleteProject(int projectId) async {
    try {
      final response = await _api.delDeleteProjectEntry(projectId);
      if (response.statusCode != 200) {
        _log.warning('Failed to delete project: ${response.statusCode}');
        return;
      }
      loadProjects();
    } catch (e) {
      _log.severe('Error deleting project: $e');
    }
  }
}

final projectVMProvider = ChangeNotifierProvider((ref) => ProjectVMProvider(Api()));
