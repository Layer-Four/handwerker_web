import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';

import '../../../constants/themes/app_color.dart';
import '../../../constants/utilitis/utilitis.dart';
import '../../../models/time_models/time_vm/time_vm.dart';
import 'info_tale_widget.dart';

class CustomDayView extends StatelessWidget {
  const CustomDayView({super.key});
  @override
  Widget build(BuildContext context) => DayView(
        controller: CalendarControllerProvider.of(context).controller,
        minDay: DateTime.now().add(const Duration(days: -(365 * 4))),
        maxDay: DateTime.now().add(const Duration(days: 365 * 10)),
        liveTimeIndicatorSettings:
            LiveTimeIndicatorSettings(color: AppColor.kPrimaryButtonColor, height: 2),
        onEventTap: (events, date) => _showEventInofs(context, events),
        dateStringBuilder: (date, {secondaryDate}) =>
            'KW ${date.getWeekDifference(DateTime(date.year)) + 1}/ ${date.day}.${date.month}.${date.year}',
        timeLineWidth: 60,
        headerStyle: Utilitis.buildCustomHeadStyle(context),
        eventTileBuilder: (date, events, boundary, startDuration, endDuration) => ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: events.length,
            itemBuilder: (context, i) {
              final objekt = events[i].event as TimeVMAdapter;
              final user = objekt.user?.userName ?? 'Kein Nutzer gefunden';
              return Container(
                key: ValueKey(objekt.id),
                margin: const EdgeInsets.all(2),
                color: events[i].color,
                height: boundary.size.height,
                width: boundary.width / events.length + 2,
                child: Text(
                  '${events[i].title}/\n$user',
                  style: const TextStyle(color: Colors.white),
                  overflow: TextOverflow.clip,
                ),
              );
            }),
      );

  Future<dynamic> _showEventInofs(BuildContext context, List<CalendarEventData<Object?>> events) =>
      showDialog(
          barrierColor: const Color.fromARGB(20, 0, 0, 0),
          context: context,
          builder: (context) {
            final e = events.map((e) => e.event as TimeVMAdapter).toList();
            if (e.length > 1) {
              throw Exception('events more than expactet');
            }
            return Dialog(
              child: Container(
                width: MediaQuery.of(context).size.width > 900
                    ? 700
                    : MediaQuery.of(context).size.width / 10 * 85,
                height: MediaQuery.of(context).size.height > 800
                    ? 400
                    : MediaQuery.of(context).size.height / 10 * 8,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColor.kTextfieldBorder),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Material(
                  borderRadius: BorderRadius.circular(6),
                  clipBehavior: Clip.antiAlias,
                  child: InfoTableWidget(entry: e.first),
                ),
              ),
            );
          });
}
