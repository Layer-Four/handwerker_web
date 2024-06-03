import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/api/api.dart';
import '../../models/consumable_models/consumable_vm/consumable_vm.dart';
import '../../models/consumable_models/unit/unit.dart';

final consumableProvider = NotifierProvider<ConsumeableNotifier, List<ConsumableVM>>(() => ConsumeableNotifier());

class ConsumeableNotifier extends Notifier<List<ConsumableVM>> {
  final Api _api = Api();

  @override
  List<ConsumableVM> build() {
    loadConsumables();
    return [];
  }

  Future<void> loadConsumables() async {
    final List<ConsumableVM> result = [];
    final units = await loadUnits();
    try {
      final response = await _api.getMaterialsList;
      if (response.statusCode != 200) {
        throw Exception('Error on loading Material, status-> ${response.statusCode}\n ${response.data}');
      }
      final List data = response.data.map((e) => e).toList();
      for (var e in data) {
        final unitKey = e['materialUnitName'];
        final searchedUnit = units.firstWhere(
          (unit) => unit.name == unitKey,
          orElse: () {
            log('Unit with name $unitKey not found. Using default unit.');
            return Unit(id: -1, name: 'Unknown');
          },
        );

        final material = ConsumableVM.wihUnitAndJson(e, searchedUnit);
        log(material.toJson().toString());
        result.add(material);
      }
      state = result;
    } catch (e) {
      log('Error loading consumables: $e');
    }
  }

  Future<List<Unit>> loadUnits() async {
    final result = <Unit>[];
    try {
      final response = await _api.getAllUnits;
      if (response.statusCode != 200) {
        throw Exception('Wrong Response occurred, status -> ${response.statusCode}  \n${response.data}');
      }
      final List data = response.data.map((e) => e).toList();

      for (var e in data) {
        final entry = Unit.fromJson(e);
        result.add(entry);
      }
      log('Loaded ${result.length} units.');
    } on DioException catch (e) {
      log('DioException: $e');
      throw Exception(e);
    } catch (e) {
      log('Exception: $e');
      throw Exception(e);
    }
    return result;
  }

  Future<void> deleteConsumable(int id) async {
    try {
      final response = await _api.deleteServiceMaterial(id);
      log('Received response: ${response.data}');
      log('Response status code: ${response.statusCode}');

      if (response.statusCode == 200 || response.statusCode == 204) {
        log('Successfully deleted row with ID: $id from the backend.');
        state = state.where((item) => item.id != id).toList();
      } else {
        log('Failed to delete row with ID: $id. Status code: ${response.statusCode}, response: ${response.data}');
        throw Exception('Failed to delete the item from the server: ${response.statusCode}');
      }
    } catch (e) {
      log('Exception when trying to delete row with ID: $id: $e');
      throw Exception('Error when attempting to delete the item: $e');
    }
  }
}
