import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../constants/themes/app_color.dart';
import '../../../constants/utilitis/utilitis.dart';
import '../../../models/time_models/time_vm/time_vm.dart';
import '../../../provider/data_provider/time_entry_provider/time_entry_provider.dart';
import '../../shared_view_widgets/search_line_header.dart';
import 'time_entry_dialog.dart';

class WorkAssignmenView extends ConsumerWidget {
  const WorkAssignmenView({super.key});

  @override
  Widget build(BuildContext context, ref) => const Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SearchLineHeader(title: 'Stundenübersicht', searchbarEnabled: false),
            CustonWeekView(),
          ],
        ),
      );
}

class CustonWeekView extends ConsumerStatefulWidget {
  const CustonWeekView({super.key});
  @override
  ConsumerState<CustonWeekView> createState() => _CustomWeekViewState();
}

class _CustomWeekViewState extends ConsumerState<CustonWeekView> {
  final EventController _eventCtr = EventController();
  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  void _loadEvents() => ref.read(eventSourceProvider.notifier).loadEvents().then(
        (i) => setState(() => _eventCtr..addAll(i)),
      );

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) {
      if (_eventCtr.allEvents.isEmpty) _loadEvents();
    });
    return CalendarControllerProvider(
      controller: EventController()..addAll(_eventCtr.allEvents),
      child: Material(
        borderRadius: BorderRadius.circular(8),
        clipBehavior: Clip.antiAlias,
        elevation: 9,
        child: SizedBox(
          height: MediaQuery.of(context).size.height - 100,
          child: WeekView(
            weekTitleHeight: 90,
            weekDayBuilder: (DateTime day) => _buildWeekDayIcon(context, day),
            timeLineWidth: 60,
            headerStringBuilder: (date, {secondaryDate}) =>
                '${date.day}.${date.month} - ${secondaryDate?.day}.${secondaryDate?.month}.${secondaryDate?.year}',
            headerStyle: _customHeadStyle(context),
            minDay: DateTime.now().add(const Duration(days: -(365 * 4))),
            maxDay: DateTime.now().add(const Duration(days: 365 * 10)),
            // eventArranger: const SideEventArranger(),
            eventTileBuilder: (
              date,
              events,
              boundary,
              startDuration,
              endDuration,
            ) =>
                ListView.builder(
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
                          itemBuilder: (context, i) => InfoTable(entry: e[i]),
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }

  HeaderStyle _customHeadStyle(BuildContext context) => HeaderStyle(
        leftIcon: Container(
          alignment: Alignment.centerRight,
          width: MediaQuery.of(context).size.width / 3.8,
          child: Icon(
            Icons.arrow_left_outlined,
            size: 45,
            color: AppColor.kPrimaryButtonColor,
          ),
        ),
        rightIcon: Container(
          alignment: Alignment.centerLeft,
          width: MediaQuery.of(context).size.width / 3.18,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.arrow_right_outlined,
                size: 45,
                color: AppColor.kPrimaryButtonColor,
              ),
              InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) => Dialog(
                            elevation: 5,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white, borderRadius: BorderRadius.circular(8)),
                              height: MediaQuery.of(context).size.height - 200,
                              width: 500,
                              child: const TimeEntryDialog(),
                            ),
                          ));
                },
                child: Material(
                  borderRadius: BorderRadius.circular(8),
                  elevation: 5,
                  color: AppColor.kPrimaryButtonColor,
                  clipBehavior: Clip.antiAlias,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                    child: Text(
                      'Neuer Termin',
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // Icon(Icons.arrow_left_outlined),
        headerTextStyle: Theme.of(context).textTheme.titleLarge,
        decoration: const BoxDecoration(color: Colors.white),
      );
}

Widget _buildWeekDayIcon(BuildContext context, DateTime day) {
  double width = MediaQuery.of(context).size.width;
  bool isToday = (DateTime.now().year == day.year) &&
      (DateTime.now().month == day.month) &&
      (DateTime.now().day == day.day);
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: width < 1000 ? 12.0 : 33.0, vertical: 8),
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
}

class InfoTable extends StatelessWidget {
  final TimeVMAdapter entry;
  const InfoTable({
    required this.entry,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
            border: Border.all(color: AppColor.kTextfieldBorder),
            borderRadius: BorderRadius.circular(6),
            color: AppColor.kWhite),
        margin: const EdgeInsets.all(6),
        padding: const EdgeInsets.all(6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Am ${entry.date.day}.${entry.date.month}.${entry.date.year}'),
            Text('von ${entry.startTime.hour}:${entry.startTime.minute}'),
            Text('bis ${entry.endTime.hour}:${entry.endTime.minute}'),
            Text('Dauer ${entry.duration} min'),
            Text('Beschreibung ${entry.description}'),
          ],
        ),
      );
}
