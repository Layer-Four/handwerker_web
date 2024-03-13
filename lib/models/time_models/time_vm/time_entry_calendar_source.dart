import 'package:handwerker_web/models/time_models/time_vm/time_vm.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class EventSource extends CalendarDataSource {
  EventSource(List<TimeEntry> appointments) {
    this.appointments = appointments;
  }
  TimeEntry getTimeEntry(int index) => appointments![index] as TimeEntry;
  @override
  DateTime getStartTime(int index) => getTimeEntry(index).startTime;
  @override
  DateTime getEndTime(int index) => getTimeEntry(index).endTime;

  String getEntryTitle(int index) => getTimeEntry(index).title;

  String getEntryID(int index) => getTimeEntry(index).timeEntryID;

  String? getEntryColor(int index) => getTimeEntry(index).useForColor;

  String? getEntryDescription(int index) => getTimeEntry(index).description;
  int? get length => appointments?.length;
}
