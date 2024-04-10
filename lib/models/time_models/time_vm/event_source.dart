import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'time_vm.dart';

class EventSource extends CalendarDataSource {
  EventSource({List<TimeVMAdapter>? appointments}) {
    this.appointments = appointments;
  }
  TimeVMAdapter getTimeEntry(int index) => appointments![index] as TimeVMAdapter;
  @override
  DateTime getStartTime(int index) => getTimeEntry(index).startTime;
  @override
  DateTime getEndTime(int index) => getTimeEntry(index).endTime;

  String? getEntryTitle(int index) => getTimeEntry(index).serviceTitle;

  int? getEntryID(int index) => getTimeEntry(index).id;
  // List getEntrysOfDay=>_
  // String? getEntryColor(int index) => getTimeEntry(index).useForColor;

  String? getEntryDescription(int index) => getTimeEntry(index).description;
  int? get length => appointments?.length;
}
