import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/api/api.dart';
import '../../models/consumable_models/consumable_vm/consumable_vm.dart';
import '../../models/consumable_models/unit/unit.dart';

final consumableProvider = NotifierProvider<ConsumeableNotifier, List<ConsumableVM>>(() => ConsumeableNotifier());

class ConsumeableNotifier extends Notifier<List<ConsumableVM>> {
  /// Instance from Api class for Internet Api Request
  final Api _api = Api();

  /// Default value when [consumableProvider] initialized
  @override
  List<ConsumableVM> build() {
    loadConsumables();
    return [];
  }

  Future<List<Unit>> loadConsumables() async {
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
        final searchedUnit = units.firstWhere((unit) => unit.name == unitKey);
        final material = ConsumableVM.wihUnitAndJson(e, searchedUnit);
        log(material.toJson().toString());
        result.add(material);
      }
      state = result;
    } catch (e) {
      log('Error loading consumables: $e');
    }
    return units;
  }

  /// Method that loads Units from Database via [Api] instance
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
}
