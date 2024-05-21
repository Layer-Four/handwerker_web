import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';

import '../../../models/time_models/time_vm/work_events.dart';
import '../../shared_view_widgets/search_line_header.dart';

class WorkAssignmenView extends StatelessWidget {
  const WorkAssignmenView({super.key});

  @override
  Widget build(BuildContext context) => CalendarControllerProvider(
        controller: EventController()..addAll(events),
        child: SizedBox(
          height: MediaQuery.of(context).size.height - 100,
          width: MediaQuery.of(context).size.width - 100,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SearchLineHeader(
                  title: 'Stundenüberischt',
                  searchbarEnabled: false,
                ),
                Expanded(
                  child: Material(
                      clipBehavior: Clip.antiAlias,
                      borderRadius: BorderRadius.circular(9),
                      elevation: 5,
                      child: WeekView(
                        minDay: DateTime(2020),
                      )),
                ),
              ],
            ),
          ),
        ),
      );
}

final _now = DateTime.now();
final events = [
  WorkEvents(
    date: _now,
    startTime: DateTime(_now.year, _now.month, _now.day, 8),
    title: 'Austausch Waschbecken',
  ),
];
