import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../constants/api/api.dart';
import '../../models/consumable_models/consumable_vm/consumable_vm.dart';
import '../../models/consumable_models/unit/unit.dart';

final consumableProvider = NotifierProvider<ConsumeableNotifier, List<ConsumableVM>>(() => ConsumeableNotifier());

class ConsumeableNotifier extends Notifier<List<ConsumableVM>> {
// final TextEditingController _materialController = TextEditingController();
// final TextEditingController _amountController = TextEditingController();
// final TextEditingController _priceController = TextEditingController();
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
            return const Unit(id: -1, name: 'Unknown');
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
      // final List data = response.data.map((e) => e).toList();
      final List data = response.data as List;
      for (var e in data) {
        final entry = Unit.fromJson(e as Map<String, dynamic>);
        result.add(entry);
      }
      return result;
    } on DioException catch (e) {
      log('DioException: $e');
      throw Exception(e);
    } catch (e) {
      log('Exception: $e');
      throw Exception(e);
    }
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

  Future<void> createService(String material, int amount, Unit unit, int price) async {
    try {
      final response = await _api.postCardMaterial({
        // Assuming your API expects a JSON body containing material details
        'name': material,
        'amount': amount,
        'materialUnitID': unit.id, // use unit.id
        'price': price,
      });

      if (response.statusCode != 200) {
        throw Exception('Wrong Response occurred, status -> ${response.statusCode}');
      }

      final id = response.data['id'] as int; // Extract ID

      final newMaterial = ConsumableVM(
        id: id,
        name: material,
        amount: amount,
        unit: unit,
        price: price,
      );

      // Update state immutably
      state = [...state, newMaterial];
    } on DioException catch (error) {
      log(error.message ?? 'DioException -> ${jsonEncode(error)}');
    } catch (error) {
      log('Error on createService: $error');
      rethrow;
    } finally {
      // Clear text fields regardless of success or failure
      // _materialController.clear();
      // _amountController.clear();
      // _priceController.clear();
    }
  }

  Future<bool> updateConsumable(ConsumableVM consumble) async {
    try {
      final data = consumble.toJson();
      log('Sending update request with data: $data');
      final response = await _api.postUpdateConsumableEntry(data);
      if (response.statusCode != 200) {
        log('Update response: ${response.data}');
        log('Update failed with status: ${response.statusCode}, response: ${response.data}');
        var errMsg = 'Failed to update item: ${response.statusCode}';
        if (response.statusCode == 400) {
          errMsg += ' - Bad Request, check data';
        } else if (response.statusCode == 404) {
          errMsg += ' - Item not found';
        } else if (response.statusCode == 500) {
          errMsg += ' - Server error';
        }
        log(errMsg);
        throw Exception('Exception on updateConsumable status-> ${response.statusCode}\n${response.data}');
      }
      return true;
    } on DioException catch (e) {
      log('Network error: ${e.message}');
      if (e.response != null) {
        log('Response status code: ${e.response?.statusCode}');
        log('Response data: ${e.response?.data}');
        log('Response headers: ${e.response?.headers}');
        log('Request options: ${e.response?.requestOptions}');
        return false;
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
    return false;
  }
}
