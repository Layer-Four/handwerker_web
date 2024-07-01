import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';

import '../../../constants/themes/app_color.dart';
import '../../../constants/utilitis/utilitis.dart';
import '../../../models/time_models/time_vm/time_vm.dart';
import 'info_tale_widget.dart';

class CustomWeekView extends StatelessWidget {
  const CustomWeekView({super.key});

  @override
  Widget build(BuildContext context) => WeekView(
        controller: CalendarControllerProvider.of(context).controller,
        weekTitleHeight: 70,
        liveTimeIndicatorSettings:
            LiveTimeIndicatorSettings(color: AppColor.kPrimaryButtonColor, height: 2),
        weekDayBuilder: (DateTime day) {
          double width = MediaQuery.of(context).size.width;
          bool isToday = (DateTime.now().year == day.year) &&
              (DateTime.now().month == day.month) &&
              (DateTime.now().day == day.day);
          return Container(
            margin: EdgeInsets.symmetric(horizontal: width < 1000 ? 12.0 : 30.0, vertical: 6),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: isToday ? AppColor.kPrimaryButtonColor : AppColor.kTextfieldBorder),
            child: Text(
              '${day.day}\n${Utilitis.getWeekDayString(day.weekday)}',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: isToday ? AppColor.kWhite : null,
                  ),
              textAlign: TextAlign.center,
            ),
          );
        },
        timeLineWidth: 60,
        headerStringBuilder: (date, {secondaryDate}) =>
            '${date.day}.${date.month} - ${secondaryDate?.day}.${secondaryDate?.month}.${secondaryDate?.year}',
        headerStyle: Utilitis.buildCustomHeadStyle(context),
        minDay: DateTime.now().add(const Duration(days: -(365 * 4))),
        maxDay: DateTime.now().add(const Duration(days: 365 * 10)),
        eventTileBuilder: (date, events, boundary, startDuration, endDuration) => ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: events.length,
            itemBuilder: (context, i) {
              final objekt = events[i].event as TimeVMAdapter;
              final user = objekt.user?.userName ?? 'Kein Nutzer gefunden';
              return Container(
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
        onEventTap: (events, date) => showDialog(
            barrierColor: const Color.fromARGB(20, 0, 0, 0),
            context: context,
            builder: (context) {
              final k = events.map((e) => e.event as TimeVMAdapter).toList();
              return Dialog(
                child: Container(
                  width: MediaQuery.of(context).size.width > 900
                      ? 700
                      : MediaQuery.of(context).size.width * 0.85,
                  height: MediaQuery.of(context).size.height > 800
                      ? 400
                      : MediaQuery.of(context).size.height * 0.8,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColor.kTextfieldBorder),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Material(
                    borderRadius: BorderRadius.circular(6),
                    clipBehavior: Clip.antiAlias,
                    child: ListView.builder(
                      itemCount: k.length,
                      itemBuilder: (context, i) => InfoTableWidget(entry: k[i]),
                    ),
                  ),
                ),
              );
            }),
      );
}
