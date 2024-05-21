import 'dart:math';

import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/themes/app_color.dart';
import '../../../constants/utilitis/utilitis.dart';
import '../../../models/time_models/time_vm/time_vm.dart';
import '../../../models/time_models/time_vm/work_events.dart';
import '../../../provider/data_provider/time_entry_provider/time_entry_provider.dart';
import '../../shared_view_widgets/search_line_header.dart';
import 'time_entry_dialog.dart';

class WorkAssignmenView extends ConsumerStatefulWidget {
  const WorkAssignmenView({super.key});

  @override
  ConsumerState<WorkAssignmenView> createState() => _WorkAssignmenViewState();
}

class _WorkAssignmenViewState extends ConsumerState<WorkAssignmenView> {
  @override
  Widget build(BuildContext context) => Padding(
        // height: MediaQuery.of(context).size.height - 100,
        // width: MediaQuery.of(context).size.width - 100,
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SearchLineHeader(
              title: 'Stundenübersicht',
              searchbarEnabled: false,
            ),
            Stack(
              children: [
                const CustonWeekView(),
                _showNewTimeEntryButton(MediaQuery.of(context).size.width, context, ref),
              ],
            ),
          ],
        ),
      );

  Positioned _showNewTimeEntryButton(
    double width,
    BuildContext context,
    WidgetRef ref,
  ) =>
      Positioned(
        right: width / 20.0,
        top: 15,
        child: InkWell(
          onTap: () {
            showDialog(
                // barrierColor: Colors.transparent,
                context: context,
                builder: (context) => Dialog(
                      elevation: 5,
                      // shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white, borderRadius: BorderRadius.circular(8)),
                        height: MediaQuery.of(context).size.height - 200,
                        width: 500,
                        child: const TimeEntryDialog(),
                      ),
                    ));
            // log(ref.watch(timeEntryProvider).toString());
          },
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: Container(
              alignment: Alignment.center,
              color: Colors.orange,
              height: 30,
              width: 150,
              child: const Text('+ Neuer Termin'),
            ),
          ),
        ),
      );

  Widget _customCalendarWeekView(BuildContext context) => Localizations.override(
        context: context,
        locale: const Locale('de'),
        child: Card(
            clipBehavior: Clip.antiAlias,
            elevation: 5,
            child: WeekView(
              // TODO: Builder for weekdaycard
              weekTitleHeight: 90,
              weekDayBuilder: (DateTime day) {
                double width = MediaQuery.of(context).size.width;
                bool isToday = (DateTime.now().year == day.year) &&
                    (DateTime.now().month == day.month) &&
                    (DateTime.now().day == day.day);
                return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: width < 1000 ? 12.0 : 33.0, vertical: 8),
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
                // return Flexible(
                //   flex: 8,
                //   child: Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: Container(
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(8),
                //         color: isToday ? AppColor.kPrimaryButtonColor : AppColor.kTextfieldBorder,
                //       ),
                //       // margin: EdgeInsets.symmetric(
                //       //     horizontal: MediaQuery.of(context).size.width / 45, vertical: 4),
                //       height: 40,
                //       width: 30,
                //       alignment: Alignment.center,
                //       // padding: EdgeInsets.all(8),
                //       child: Text(
                //         '${day.day}\n${getWeekDayString(day.weekday)}',
                //         style: Theme.of(context)
                //             .textTheme
                //             .labelLarge
                //             ?.copyWith(color: isToday ? AppColor.kWhite : null),
                //       ),
                //     ),
                //   ),
                // );
              },
              showVerticalLines: false,
              timeLineWidth: 60,
              headerStringBuilder: (date, {secondaryDate}) =>
                  '${date.day}.${date.month}.${date.year}  -  ${secondaryDate?.day}.${secondaryDate?.month}.${secondaryDate?.year}',
              headerStyle: HeaderStyle(
                // TODO: Test example with adaptiv
                leftIcon: Container(
                  alignment: Alignment.centerRight,
                  width: MediaQuery.of(context).size.width / 4,
                  child: Icon(
                    Icons.arrow_left_outlined,
                    size: 45,
                    color: AppColor.kPrimaryButtonColor,
                  ),
                ),
                rightIcon: Container(
                  alignment: Alignment.centerLeft,
                  width: MediaQuery.of(context).size.width / 4,
                  child: Icon(
                    Icons.arrow_right_outlined,
                    size: 45,
                    color: AppColor.kPrimaryButtonColor,
                  ),
                ),
                // Icon(Icons.arrow_left_outlined),
                headerTextStyle: Theme.of(context).textTheme.titleLarge,
                decoration: const BoxDecoration(color: Colors.white),
              ),
              minDay: DateTime(2020),
              maxDay: DateTime.now().add(const Duration(days: 365 * 60)),
            )),
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
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 9,
      child: SizedBox(
        height: MediaQuery.of(context).size.height - 110,
        child: Localizations.override(
          context: context,
          locale: const Locale('de'),
          child: CalendarControllerProvider(
            controller: _eventCtr,
            child: WeekView(
              onEventTap: (events, date) => showDialog(
                  context: context,
                  builder: (context) {
                    final e = events.map((e) => e.event as TimeVMAdapter).toList();
                    return Dialog(
                      child: Material(
                        child: ListView.builder(
                          itemCount: e.length,
                          itemBuilder: (context, i) => InfoTable(entry: e[i]),
                        ),
                      ),
                    );
                  }),
              // TODO: Builder for weekdaycard
              weekTitleHeight: 90,
              weekDayBuilder: (DateTime day) {
                double width = MediaQuery.of(context).size.width;
                bool isToday = (DateTime.now().year == day.year) &&
                    (DateTime.now().month == day.month) &&
                    (DateTime.now().day == day.day);
                return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: width < 1000 ? 12.0 : 33.0, vertical: 8),
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
              showVerticalLines: false,
              timeLineWidth: 60,
              headerStringBuilder: (date, {secondaryDate}) =>
                  '${date.day}.${date.month}.${date.year}  -  ${secondaryDate?.day}.${secondaryDate?.month}.${secondaryDate?.year}',
              headerStyle: HeaderStyle(
                // TODO: Test example with adaptiv
                leftIcon: Container(
                  alignment: Alignment.centerRight,
                  width: MediaQuery.of(context).size.width / 4,
                  child: Icon(
                    Icons.arrow_left_outlined,
                    size: 45,
                    color: AppColor.kPrimaryButtonColor,
                  ),
                ),
                rightIcon: Container(
                  alignment: Alignment.centerLeft,
                  width: MediaQuery.of(context).size.width / 4,
                  child: Icon(
                    Icons.arrow_right_outlined,
                    size: 45,
                    color: AppColor.kPrimaryButtonColor,
                  ),
                ),
                // Icon(Icons.arrow_left_outlined),
                headerTextStyle: Theme.of(context).textTheme.titleLarge,
                decoration: const BoxDecoration(color: Colors.white),
              ),
              minDay: DateTime(2020),
              maxDay: DateTime.now().add(const Duration(days: 365 * 60)),
            ),
          ),
        ),
      ),
    );
  }
}

class InfoTable extends StatelessWidget {
  final TimeVMAdapter entry;
  const InfoTable({
    required this.entry,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Am ${entry.date.day}.${entry.date.month}.${entry.date.year}'),
        Text('von ${entry.startTime?.hour ?? ''}:${entry.startTime?.minute ?? ''}'),
        Text('bis ${entry.endTime?.hour ?? ''}:${entry.endTime?.minute ?? ''}'),
        Text('Dauer ${entry.duration} min'),
        Text('Beschreibung ${entry.description}'),
      ],
    );
  }
}
