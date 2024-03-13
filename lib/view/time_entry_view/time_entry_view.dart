import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_web/models/time_models/time_vm/time_entry_calendar_source.dart';
import 'package:handwerker_web/provider/time_entry_provider/time_entry_provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class TimeEntryBody extends ConsumerStatefulWidget {
  const TimeEntryBody({super.key});

  @override
  ConsumerState<TimeEntryBody> createState() => _TimeEntryBodyState();
}

class _TimeEntryBodyState extends ConsumerState<TimeEntryBody> {
  final CalendarController _calendarController = CalendarController();
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          _searchHeader(context),
          Stack(
            children: [
              _calendarView(context),
              // Positioned(
              //   right: MediaQuery.of(context).size.width / 2.24,
              //   top: 15,
              //   child: IconButton.filled(
              //     onPressed: () {},
              //     icon: Icon(Icons.arrow_back_ios_sharp),
              //   ),
              // ),
              // Positioned(
              //     right: MediaQuery.of(context).size.width / 3.4,
              //     top: 15,
              //     child: IconButton.filled(
              //         onPressed: () {}, icon: Icon(Icons.arrow_forward_ios_sharp))),
              Positioned(
                right: MediaQuery.of(context).size.width / 20.0,
                top: 15,
                child: InkWell(
                  onTap: () {},
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    child: Container(
                      alignment: Alignment.center,
                      color: Colors.orange,
                      height: 30,
                      width: 150,
                      child: Text('+ Neuer Termin'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _calendarView(BuildContext context) {
    return ref.watch(timeEntryProvider).when(
        data: (data) {
          log('${data?.length}');
          if (data == null) {
            ref.read(timeEntryProvider.notifier).loadTimeEntrys();
            return CircularProgressIndicator();
          }
          return Card(
            elevation: 9,
            child: Localizations.override(
              context: context,
              locale: const Locale('de'),
              child: Container(
                  height: MediaQuery.of(context).size.height - 106,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.white),
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
        },
        error: (e, st) {
          return Container(child: Text('$e'));
        },
        loading: () => CircularProgressIndicator.adaptive());
  }

  Padding _searchHeader(BuildContext context) {
    return Padding(
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
  }

  Container _showAppointmentDetails(CalendarTapDetails calendarTapDetails) {
    return Container(
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
}
