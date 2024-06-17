import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/api/api.dart';
import '../../models/customer_models/customer_create_model/create_customer_model.dart';
import '../user_provider/user_provider.dart';

final customerProvider = NotifierProvider<CustomerNotifier, List<CreateCustomerDM>>(() => CustomerNotifier());

class CustomerNotifier extends Notifier<List<CreateCustomerDM>> {
  CreateCustomerDM? _createCustomer;
  final Api _api = Api();

  @override
  List<CreateCustomerDM> build() {
    loadAllCustomers();
    return [];
  }

  Future<void> loadAllCustomers() async {
    try {
      final response = await _api.getAllCustomers;
      if (response.statusCode != 200) {
        throw Exception('Wrong response occurred, status -> ${response.statusCode} \n${response.data}');
      }

      final List data = response.data as List;
      final List<CreateCustomerDM> result = [];
      for (var e in data) {
        final entry = CreateCustomerDM.fromJson(e as Map<String, dynamic>);
        result.add(entry);
      }

      if (result.isNotEmpty) {
        _createCustomer = result.first;
      }

      state = result;
    } on DioException catch (e) {
      log('DioException: $e');
      throw Exception(e);
    } catch (e) {
      log('Exception: $e');
      throw Exception(e);
    }
  }

  CreateCustomerDM? get currentCustomer {
    if (_createCustomer == null) {
      log('The _createCustomer field has not been initialized.');
    }
    return _createCustomer;
  }

  Future<bool> createCustomer(CreateCustomerDM customer) async {
    final userToken = ref.watch(userProvider).userToken;
    log(userToken);
    log(jsonEncode(customer));
    try {
      final response = await _api.postCreateCustomer(customer.toJson());
      if (response.statusCode != 200) {
        throw Exception('Exception occurred on addCustomer, status: ${response.statusCode}\n${response.data}');
      }
      log('${response.data}');
      log(state.length.toString());
      state = [...state, CreateCustomerDM.fromJson(response.data)];
      log(state.length.toString());
      return true;
    } on DioException catch (e) {
      throw Exception(
          'DioException occurred on addCustomer with this message: ${e.message} \nstatus: ${e.response?.statusCode}\n${e.response?.data}');
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
