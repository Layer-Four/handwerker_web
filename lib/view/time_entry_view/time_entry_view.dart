import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../models/time_models/time_vm/time_entry_adapter.dart';
import '../../provider/time_entry_provider/time_entry_provider.dart';
import 'time_entry_dialog.dart';

class TimeEntryBody extends ConsumerStatefulWidget {
  const TimeEntryBody({super.key});

  @override
  ConsumerState<TimeEntryBody> createState() => _TimeEntryBodyState();
}

class _TimeEntryBodyState extends ConsumerState<TimeEntryBody> {
  final CalendarController _calendarController = CalendarController();
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) => Container(
        color: Colors.white,
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            _searchHeader(context),
            Stack(
              children: [
                _calendarView(context),
                _addNewAppointment(context),
              ],
            ),
          ],
        ),
      );

  Widget _addNewAppointment(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Positioned(
      right: width / 20.0,
      top: 15,
      child: InkWell(
        onTap: () {
          showDialog(
              barrierColor: Colors.transparent,
              context: context,
              builder: (context) => Container(
                    width: 600,
                    height: 1000,
                    margin: EdgeInsets.only(
                        left: (width / 10) * 5,
                        top: (height / 10) * 1.0,
                        right: (width / 10) * 1.0,
                        bottom: (height / 10) * 1.0),
                    child: Card(
                        elevation: 5,
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                // border: Border.all(
                                //   color: const Color.fromARGB(255, 220, 217, 217),
                                // ),
                                borderRadius: BorderRadius.circular(12)),
                            child: const TimeEntryDialog())),
                  ));
        },
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Container(
            alignment: Alignment.center,
            color: Colors.orange,
            height: 30,
            width: 150,
            child: const Text('+ Neuer Termin'),
          ),
        ),
      ),
    );
  }

// some changes
  Widget _calendarView(BuildContext context) => ref.watch(timeEntryProvider).when(
      data: (data) {
        log('${data?.length}');
        if (data == null) {
          ref.read(timeEntryProvider.notifier).loadTimeEntrys();
        }
        return _buildCalendarWidget(context, data);
      },
      error: (e, st) {
        log('this was the Stacke-> $st');
        return Text('$e');
      },
      loading: () => const CircularProgressIndicator.adaptive());

  Card _buildCalendarWidget(BuildContext context, EventSource? data) => Card(
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
                  if (calendarTapDetails.appointments != null) {
                    showDialog(
                        context: context,
                        builder: (context) => _showAppointmentDetails(calendarTapDetails));
                  }
                },
              )),
        ),
      );

  Widget _searchHeader(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: SizedBox(
          height: 50,
          width: double.infinity,
          child: Row(
            children: [
              Text(
                'Stundenübersicht',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontWeight: FontWeight.w600, color: Colors.orange),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 100.0),
                child: Card(
                  elevation: 5,
                  child: Container(
                    width: MediaQuery.of(context).size.width / 3,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.white),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (value) {
                        _searchController.text = value;
                      },
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                        suffixIcon: const Icon(Icons.search),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );

  Container _showAppointmentDetails(CalendarTapDetails calendarTapDetails) => Container(
        margin: const EdgeInsets.only(left: 500, top: 100, right: 100, bottom: 100),
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
      );
}
