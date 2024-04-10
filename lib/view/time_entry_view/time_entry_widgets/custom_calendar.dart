import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '/models/time_models/time_vm/event_source.dart';
import '/models/time_models/time_vm/time_vm.dart';
import '/provider/data_provider/time_entry_provider/time_entry_provider.dart';

class CustomCalendar extends ConsumerStatefulWidget {
  const CustomCalendar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends ConsumerState<CustomCalendar> {
  @override
  void initState() {
    super.initState();
    loadEventSource();
  }

  final CalendarController _calendarController = CalendarController();
  EventSource? data;

  Future<EventSource?> loadEventSource() async =>
      ref.read(eventSourceProvider.notifier).loadTimeEntrys().then((value) => data = value);

  // Future<ServiceVM> loadServiceVM() async => ref.read(serviceVMProvider.notifier).loadServices();
  @override
  Widget build(BuildContext context) => FutureBuilder<EventSource?>(
      future: loadEventSource(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          const CircularProgressIndicator();
        }
        if (snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
          data = snapshot.data;
        }
        return Card(
          clipBehavior: Clip.antiAlias,
          elevation: 9,
          child: Localizations.override(
            context: context,
            locale: const Locale('de'),
            child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height - 106,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
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
                  appointmentBuilder: (context, calendarAppointmentDetails) {
                    assert((calendarAppointmentDetails.appointments.length == 1));
                    if (calendarAppointmentDetails.appointments.length != 1) {
                      throw Exception(
                          'The length of appointments are longer as wanted, please fix this bug');
                    }
                    return CalendarEntryItem(
                        item: calendarAppointmentDetails.appointments.first as TimeVMAdapter);
                  },
                )),
          ),
        );
      });
}

class CalendarEntryItem extends ConsumerStatefulWidget {
  final TimeVMAdapter item;

  const CalendarEntryItem({super.key, required this.item});

  @override
  ConsumerState<CalendarEntryItem> createState() => _CalendarEntryItemState();
}

class _CalendarEntryItemState extends ConsumerState<CalendarEntryItem> {
  late TimeVMAdapter _item;
  @override
  void initState() {
    super.initState();
    _item = widget.item;
  }

  // Future<String> getServiceName(int id) async {
  //   final services = ref.watch(serviceVMProvider);
  //   if (services == null || services.isEmpty) {
  //     final reloadeService = await ref.read(serviceVMProvider.notifier).loadServices();
  //     return reloadeService.firstWhere((element) => element.id == id).name;
  //   }
  //   return services.firstWhere((element) => element.id == id).name;
  // }

  @override
  Widget build(BuildContext context) =>
      // FutureBuilder(
      //       future: getServiceName(_item.id),
      //       builder: (context, snapshot) {
      //         String data = '';
      //         if (snapshot.connectionState == ConnectionState.waiting) {
      //           CircularProgressIndicator();
      //         }
      //         if (snapshot.data == null || snapshot.data!.isEmpty) {
      //           getServiceName(_item.id).then((value) => data = value);
      //         } else {
      //           data = snapshot.data!;
      //         }

      // return
      GestureDetector(
          onTap: () => showDialog(
              context: context,
              builder: (context) => Dialog(
                    child: Material(
                        child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Am ${_item.date.day}.${_item.date.month}.${_item.date.year}'),
                        Text('von ${_item.startTime.hour}:${_item.startTime.minute}'),
                        Text('bis ${_item.endTime.hour}:${_item.endTime.minute}'),
                        Text('Dauer ${_item.duration} min'),
                        Text('Beschreibung ${_item.description}'),
                      ],
                    )),
                  )),
          child: Container(
            color: Colors.lightBlue,
          ));
  // },
  // );
}
