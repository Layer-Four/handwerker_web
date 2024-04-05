import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../constants/api/api.dart';
import '../../models/service_models/service_vm/service_vm.dart';

final serviceVMProvider =
    AsyncNotifierProvider<ServiceNotifer, List<ServiceVM>?>(() => ServiceNotifer());

class ServiceNotifer extends AsyncNotifier<List<ServiceVM>?> {
  final Api api = Api();
  @override
  List<ServiceVM>? build() => null;

  void loadServices() async {
    try {
      final response = await api.getExecuteableServices;
      if (response.statusCode == 200) {
        final data = json.decode(response.data);
        final services = data.map<ServiceVM>((e) => ServiceVM.fromJson(e)).toList();

        state = AsyncValue.data(services);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
