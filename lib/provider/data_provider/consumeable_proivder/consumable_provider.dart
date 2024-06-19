import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../constants/api/api.dart';
import '../../../models/consumable_models/consumable_vm/consumable_vm.dart';
import '../../../models/consumable_models/unit/unit.dart';

final consumableProvider =
    NotifierProvider<ConsumeableNotifier, List<ConsumableVM>>(() => ConsumeableNotifier());

class ConsumeableNotifier extends Notifier<List<ConsumableVM>> {
  final List<Unit> _units = [];
  final Api _api = Api();

  @override
  List<ConsumableVM> build() {
    loadConsumables();
    loadUnits();
    return [];
  }

  Future<void> loadConsumables() async {
    final List<ConsumableVM> result = [];
    if (_units.isEmpty) {
      await loadUnits();
    }
    try {
      final response = await _api.getMaterialsList;
      if (response.statusCode != 200) {
        throw Exception(
          'Error on loadConsumables, status-> ${response.statusCode}\n ${response.data}',
        );
      }
      final List data = response.data.map((e) => e).toList();
      for (var e in data) {
        final String? unitKey = e['materialUnitName'];
        if (unitKey != null) {
          final searchedUnit = _units.firstWhere((unit) => unit.name == unitKey);
          final material = ConsumableVM.wihUnitAndJson(e, searchedUnit);
          result.add(material);
        } else {
          result.add(ConsumableVM.fromJson(e));
        }
      }
      state = result;
    } on DioException catch (e) {
      throw Exception('DioException: ${e.message}');
    } catch (e) {
      log('Error on loadConsumables: $e');
    }
  }

  Future<List<Unit>> loadUnits() async {
    final List<Unit> result = [];
    try {
      final response = await _api.getAllUnits;
      if (response.statusCode != 200) {
        throw Exception(
            'Wrong Response occurred, status -> ${response.statusCode}  \n${response.data}');
      }
      // final List data = response.data.map((e) => e).toList();
      final List data = response.data as List;
      for (var e in data) {
        final entry = Unit.fromJson(e as Map<String, dynamic>);
        result.add(entry);
      }
      final Set newUnits = {..._units, ...result};
      _units.clear();
      _units.addAll([...newUnits]);
      return result;
    } on DioException catch (e) {
      throw Exception('DioException: ${e.message}');
    } catch (e) {
      log('Exception: $e');
      return result;
    }
  }

  Future<bool> deleteConsumable(int id) async {
    try {
      final response = await _api.deleteConsumable(id);
      if (response.statusCode != 200) {
        throw Exception(
          'Error when attempting to deleteConsumable: ${response.statusCode}\n${response.data}',
        );
      }
      state = state.where((item) => item.id != id).toList();
      return true;
    } on DioException catch (e) {
      throw Exception('DioException: ${e.message}');
    } catch (e) {
      log('Error when attempting deleteConsumable: $e');
      return false;
    }
  }

  Future<bool> createConsumable(ConsumableVM consumable) async {
    try {
      final response = await _api.postCreateMaterial({
        // Assuming your API expects a JSON body containing material details
        'name': consumable.name,
        'amount': consumable.amount,
        'materialUnitID': consumable.unit?.id, // use unit.id
        'price': consumable.price,
      });

      if (response.statusCode != 200) {
        throw Exception('Wrong Response occurred, status -> ${response.statusCode}');
      }

      // final id = response.data['id'] as int; // Extract ID
      // final List data = response.data.map((e) => e).toList();
      final unitID = response.data['materialUnitID'];
      final searchedUnit = _units.firstWhere((e) => e.id == unitID);

      final newConsumabelList = ConsumableVM.wihUnitAndJson(response.data, searchedUnit);

      state = [...state, newConsumabelList];
      return true;
    } on DioException catch (error) {
      throw Exception(error.message ?? 'DioException -> ${jsonEncode(error)}');
    } catch (error) {
      log('Error on createService: $error');
      return false;
    }
  }

  Future<bool> updateConsumable(ConsumableVM consumble) async {
    final json = {
      'amount': consumble.amount,
      'name': consumble.name,
      'id': consumble.id,
      'price': consumble.price,
      'materialUnitID': consumble.unit?.id,
    };
    try {
      final data = json;
      final response = await _api.putUpdateConsumableEntry(data);
      if (response.statusCode != 200) {
        throw Exception(
          'Exception on updateConsumable status-> ${response.statusCode}\n${response.data}',
        );
      }
      return true;
    } on DioException catch (e) {
      throw Exception('DioException: status ${e.response?.statusCode}\n${e.message}');
    } catch (e) {
      log('Error on  updateConsumable-> $e');
      return false;
    }
  }
}
