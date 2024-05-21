import 'package:calendar_view/calendar_view.dart';

import 'time_vm.dart';

class WorkEvents extends CalendarEventData {
  WorkEvents(
      {required super.date,
      required super.startTime,
      super.endTime,
      required super.title,
      super.description,
      super.color,
      super.event});

  factory WorkEvents.fromTimeEntry(TimeVMAdapter e) => WorkEvents(
        date: e.date,
        startTime: e.startTime,
        title: e.customerName ?? '${e.projectTitle}/${e.serviceTitle}',
      );
}
