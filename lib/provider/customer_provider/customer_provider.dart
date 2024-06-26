import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/api/api.dart';
import '../../models/consumable_models/customer_overview_dm/customer_overvew_dm.dart';
import '../../models/customer_models/customer_create_model/create_customer_model.dart';
import '../../models/customer_models/customer_credential.dart';
import '../user_provider/user_provider.dart';

final customerProvider = NotifierProvider<CustomerNotifier, List<CustomerOvervewDM>>(() => CustomerNotifier());

class CustomerNotifier extends Notifier<List<CustomerOvervewDM>> {
  final Api _api = Api();

  @override
  List<CustomerOvervewDM> build() {
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
      final List<CustomerOvervewDM> result =
          data.map((e) => CustomerOvervewDM.fromJson(e as Map<String, dynamic>)).toList();
      state = result;
    } on DioException catch (e) {
      log('DioException: $e');
      throw Exception(e);
    } catch (e) {
      log('Exception: $e');
      throw Exception(e);
    }
  }

  Future<bool> createCustomer(CreateCustomerDM customer) async {
    final userToken = ref.watch(userProvider).userToken;
    log('User Token: $userToken');
    log('Customer Data: ${jsonEncode(customer)}');

    try {
      final response = await _api.postCreateCustomer(customer.toJson());

      if (response.statusCode == 200) {
        // Successful creation
        log('Create Customer Response: ${response.data}');

        // Process the response and update local state
        final createdCustomer = CreateCustomerDM.fromJson(response.data);
        final credential = CustomerCredentialDM(
          contactName: createdCustomer.contactName ?? '',
          companyName: createdCustomer.companyName,
          customerCity: createdCustomer.city,
          customerEmail: createdCustomer.contactMail,
          customerNumber: createdCustomer.externalId,
          customerPhone: createdCustomer.contactPhone,
          customerStreet: createdCustomer.street,
          customerStreetNr: createdCustomer.streetNr,
          customerZipcode: createdCustomer.zipcode,
        );

        // Update local state
        state = [...state, CustomerOvervewDM(customerCredentials: credential)];

        return true; // Indicate success
      } else {
        // Log failure response
        log('Failed to create customer. Status: ${response.statusCode}, Data: ${response.data}');
        return false; // Indicate failure
      }
    } catch (e) {
      // Log and catch any exceptions
      log('Exception during createCustomer: $e');
      return false; // Indicate failure
    }
  }

  Future<bool> updateCustomer(CreateCustomerDM customerCredential, int id) async {
    final json = {
      'id': id,
      'externalId': customerCredential.externalId,
      'CompanyName': customerCredential.companyName,
      'ContactName': customerCredential.contactName,
      'ContactPhone': customerCredential.contactPhone,
      'ContactMail': customerCredential.contactMail,
      'Street': customerCredential.street,
      'StreetNr': customerCredential.streetNr,
      'Zipcode': customerCredential.zipcode,
      'City': customerCredential.city,
    };
    try {
      log('Update Customer Data: ${jsonEncode(json)}');
      final response = await _api.putUpdateCustomer(json);
      if (response.statusCode != 200) {
        log('Update response: ${response.data}');
        throw Exception('Exception on updateCustomer status -> ${response.statusCode}\n${response.data}');
      }
      await loadAllCustomers();
      return true;
    } on DioException catch (e) {
      log('DioException: status ${e.response?.statusCode}\n${e.message}');
      return false;
    } catch (e) {
      log('Error On CustomerProvider -> $e');
      return false;
    }
  }

  Future<bool> deleteCustomer(int customerID) async {
    try {
      final response = await _api.deleteCustomer(customerID);
      if (response.statusCode != 200) {
        log('Failed to delete customer: ${response.statusCode} \n${response.data}');
        return false;
      }
      await loadAllCustomers();
      return true;
    } on DioException catch (e) {
      log('DioException ocuured while deleting customer with ID: $customerID. Error: $e');
      return false;
    }
  }
}
