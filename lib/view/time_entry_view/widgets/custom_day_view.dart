import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/utilitis/utilitis.dart';
import '../../../models/time_models/time_vm/time_vm.dart';
import 'info_tale_widget.dart';

class CustomDayView extends ConsumerStatefulWidget {
  const CustomDayView({super.key});

  @override
  ConsumerState<CustomDayView> createState() => _CustomDayViewState();
}

class _CustomDayViewState extends ConsumerState<CustomDayView> {
  @override
  Widget build(BuildContext context) => DayView(
        controller: CalendarControllerProvider.of(context).controller,
        minDay: DateTime.now().add(const Duration(days: -(365 * 4))),
        maxDay: DateTime.now().add(const Duration(days: 365 * 10)),
        onEventTap: (events, date) => _showEventInofs(context, events),
        dateStringBuilder: (date, {secondaryDate}) =>
            'KW ${date.getWeekDifference(DateTime(date.year)) + 1}/ ${date.day}.${date.month}.${date.year}',
        timeLineWidth: 60,
        headerStyle: Utilitis.buildCustomHeadStyle(context),
      );

  Future<dynamic> _showEventInofs(BuildContext context, List<CalendarEventData<Object?>> events) =>
      showDialog(
          context: context,
          builder: (context) {
            final e = events.map((e) => e.event as TimeVMAdapter).toList();
            if (e.length > 1) {
              throw Exception('events more than expactet');
            }
            return Dialog(
              child: Flexible(
                child: Material(
                  child: InfoTableWidget(entry: e.first),
                ),
              ),
            );
          });
}
