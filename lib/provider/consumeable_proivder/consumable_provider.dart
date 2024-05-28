import 'dart:convert';
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

  loadConsumables() async {
    final units = await loadUnits();
    try {
      _api.getMaterialsList.then((e) {
        if (e.statusCode != 200) {
          throw Exception('Error on loading Material, status-> ${e.statusCode}\n ${e.data}');
        }
        final List data = e.data.map((e) => e).toList();
        final result = [];
        for (var e in data) {
          final unitKey = e['materialUnitName'];
          final searchedUnit = units.firstWhere((e) => e.name == unitKey);
          final material = ConsumableVM.wihUnitAndJson(e, searchedUnit);
          log(material.toJson().toString());
          final newstate = [...state, material];
          state = newstate;
        }
        // return ConsumableVM.wihUnitAndJson(e, searchedUnit);
      });
    } catch (e) {}
  }

  ///method thats load Units from Database via [Api] instance
  Future<List<Unit>> loadUnits() async {
    final result = <Unit>[];
    try {
      final response = await _api.getAllUnits;
      if (response.statusCode != 200) {
        throw Exception('Wrong Response occurent status -> ${response.statusCode}  \n${response.data}');
      }
      final List data = response.data.map((e) => e).toList();

      for (var e in data) {
        final entry = Unit.fromJson(e);
        result.add(entry);
      }
      log(result.length.toString());
    } on DioException catch (e) {
      log(' DioException return $e');
      throw Exception(e);
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
    return result;
  }
}
