import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:handwerker_web/models/time_models/time_vm/time_vm.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_web/constants/api/url.dart';
import 'package:handwerker_web/models/time_models/time_vm/time_entry_calendar_source.dart';

final timeEntryProvider = AsyncNotifierProvider<TimeEntryNotifier, EventSource?>(
  () => TimeEntryNotifier(),
);

class TimeEntryNotifier extends AsyncNotifier<EventSource?> {
  @override
  FutureOr<EventSource?> build() => null;

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
        final entrys = data.map((e) => TimeEntry.fromJson(e)).toList();
        state = AsyncValue.data(entrys);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
