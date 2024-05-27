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
        weekDayBuilder: (DateTime day) {
          double width = MediaQuery.of(context).size.width;
          bool isToday = (DateTime.now().year == day.year) &&
              (DateTime.now().month == day.month) &&
              (DateTime.now().day == day.day);
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: width < 1000 ? 12.0 : 30.0, vertical: 6),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: isToday ? AppColor.kPrimaryButtonColor : AppColor.kTextfieldBorder),
              child: Text(
                '${day.day}\n${Utilitis.getWeekDayString(day.weekday)}',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: isToday ? AppColor.kWhite : null,
                    ),
              ),
            ),
          );
        },
        timeLineWidth: 60,
        headerStringBuilder: (date, {secondaryDate}) =>
            '${date.day}.${date.month} - ${secondaryDate?.day}.${secondaryDate?.month}.${secondaryDate?.year}',
        headerStyle: Utilitis.buildCustomHeadStyle(context),
        minDay: DateTime.now().add(const Duration(days: -(365 * 4))),
        maxDay: DateTime.now().add(const Duration(days: 365 * 10)),
        // eventArranger: const SideEventArranger(),
        eventTileBuilder: (date, events, boundary, startDuration, endDuration) => ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: events.length,
            itemBuilder: (context, i) => Container(
                  margin: const EdgeInsets.all(2),
                  color: events[i].color,
                  height: boundary.size.height,
                  width: boundary.width / events.length + 2,
                  child: Text(
                    events[i].title,
                    overflow: TextOverflow.ellipsis,
                  ),
                )),
        onEventTap: (events, date) => showDialog(
            context: context,
            builder: (context) {
              final e = events.map((e) => e.event as TimeVMAdapter).toList();
              return Dialog(
                child: Flexible(
                  child: Material(
                    child: ListView.builder(
                      itemCount: e.length,
                      itemBuilder: (context, i) => InfoTableWidget(entry: e[i]),
                    ),
                  ),
                ),
              );
            }),
      );
}
