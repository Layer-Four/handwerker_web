import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class TimeEntryBody extends ConsumerStatefulWidget {
  const TimeEntryBody({super.key});

  @override
  ConsumerState<TimeEntryBody> createState() => _TimeEntryBodyState();
}

class _TimeEntryBodyState extends ConsumerState<TimeEntryBody> {
  final CalendarController _calendarController = CalendarController();
  @override
  Widget build(BuildContext context) {
    return Localizations.override(
      context: context,
      locale: const Locale('de'),
      child: Container(
        padding: const EdgeInsets.all(8),
        width: double.infinity,
        height: double.infinity,
        child: Center(
            child: SfCalendar(
          headerDateFormat: 'MMMM.yyyy',
          headerStyle: const CalendarHeaderStyle(textAlign: TextAlign.center),
          controller: _calendarController,
          headerHeight: 80,
          view: CalendarView.week,
          firstDayOfWeek: 1,
        )),
      ),
    );
  }
  // some edits
}
