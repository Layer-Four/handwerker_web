import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../models/time_models/time_vm/time_entry_adapter.dart';
import '../../../provider/data_provider/time_entry_provider/time_entry_provider.dart';

class CustomCalendar extends ConsumerStatefulWidget {
  const CustomCalendar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends ConsumerState<CustomCalendar> {
  @override
  void initState() {
    super.initState();
    loadEventSource();
  }

  final CalendarController _calendarController = CalendarController();
  EventSource? data;

  Future<EventSource?> loadEventSource() async =>
      ref.read(timeEntryProvider.notifier).loadTimeEntrys().then((value) => data = value);

  @override
  Widget build(BuildContext context) => FutureBuilder<EventSource?>(
      future: loadEventSource(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          const CircularProgressIndicator();
        }
        if (snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
          data = snapshot.data;
          if (data != null && data!.appointments!.length > 1) {
            for (var i in data!.appointments!) {
              log('we have appointments $i');
            }
          }
        }
        return Card(
          clipBehavior: Clip.antiAlias,
          elevation: 9,
          child: Localizations.override(
            context: context,
            locale: const Locale('de'),
            child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height - 106,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
                child: SfCalendar(
                  dataSource: data,
                  showDatePickerButton: true,
                  showNavigationArrow: true,
                  todayHighlightColor: Colors.orange,
                  viewNavigationMode: ViewNavigationMode.none,
                  showWeekNumber: true,
                  minDate: DateTime(2020),
                  maxDate: DateTime(2100),
                  headerDateFormat: 'MMMM.yyyy',
                  headerStyle: const CalendarHeaderStyle(
                    textAlign: TextAlign.center,
                  ),
                  initialDisplayDate: DateTime.now(),
                  initialSelectedDate: DateTime.now(),
                  controller: _calendarController,
                  headerHeight: 65,
                  view: CalendarView.week,
                  firstDayOfWeek: 1,
                  onTap: (calendarTapDetails) {
                    // if (calendarTapDetails.appointments != null) {
                    showDialog(
                        context: context,
                        builder: (context) => Container(
                              margin: const EdgeInsets.only(
                                  left: 500, top: 100, right: 100, bottom: 100),
                              child: SizedBox(
                                width: 300,
                                height: 500,
                                child: Material(
                                  elevation: 11,
                                  child: Center(
                                    child: Text(
                                      '''${calendarTapDetails.date?.toIso8601String()}
                 ${calendarTapDetails.resource}
                  ${calendarTapDetails.appointments}
                  ${calendarTapDetails.targetElement.name}
                  ''',
                                    ),
                                  ),
                                ),
                              ),
                            ));
                    // }
                  },
                )),
          ),
        );
      });
}
