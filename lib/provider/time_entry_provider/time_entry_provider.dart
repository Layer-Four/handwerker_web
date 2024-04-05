import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
// import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/api/url.dart';
import '../../models/time_models/time_vm/time_entry_adapter.dart';
import '../../models/time_models/time_vm/time_vm.dart';

final timeEntryProvider = AsyncNotifierProvider<TimeEntryNotifier, EventSource?>(
  () => TimeEntryNotifier(),
);

class TimeEntryNotifier extends AsyncNotifier<EventSource?> {
  @override
  FutureOr<EventSource?> build() => EventSource();

  void loadTimeEntrys() async {
    final uri = const DbAdress().getTimeEntrys;
    final Dio dio = Dio();
    // final web = http.Client();
    try {
      final response = await dio.get(
        uri.path,
        // headers: {"Access-Control_Allow_Origin": "*"},
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.data);
        final entrys = data.map((e) => TimeEntryVM.fromJson(e)).toList();
        state = AsyncValue.data(entrys);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
