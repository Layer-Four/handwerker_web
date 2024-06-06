import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/time_models/time_vm/time_vm.dart';
import '../../provider/data_provider/time_entry_provider/time_entry_provider.dart';
import '../shared_widgets/search_line_header.dart';
import 'widgets/calendar_options_widget.dart';
import 'widgets/custom_day_view.dart';
import 'widgets/custom_week_view.dart';

class WorkCalendarView extends ConsumerStatefulWidget {
  const WorkCalendarView({super.key});

  @override
  ConsumerState<WorkCalendarView> createState() => _WorkCalendarViewState();
}

class _WorkCalendarViewState extends ConsumerState<WorkCalendarView> {
  final List<CalendarEventData<TimeVMAdapter>> _allEvents = [];
  late EventController _eventCtr;
  bool _isInit = false;
  bool _isWeekView = true;
  bool? _isWorkOrder;
  @override
  void initState() {
    super.initState();
    _loadEvents();
    _eventCtr = EventController();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInit) {
      WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) {
        setState(() => _isInit = true);
        if (_eventCtr.allEvents.isNotEmpty) _updateEventController(true);
      });
    }
    return CalendarControllerProvider(
      controller: _eventCtr,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Column(
          children: [
            const SearchLineHeader(title: 'Stundenübersicht'),
            CalendarOptionsRow(
              isWeekViewChoosed: _isWeekView,
              isWorkOrder: _isWorkOrder,
              onTapWeekViewView: () => setState(() => _isWeekView = true),
              onTapDayView: () => setState(() => _isWeekView = false),
              onTapTimeEntry: () => _updateEventController(false),
              onTapWorkOrder: () => _updateEventController(true),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height - 130,
              child: Material(
                borderRadius: BorderRadius.circular(6),
                clipBehavior: Clip.antiAlias,
                elevation: 9,
                child: _isWeekView ? const CustomWeekView() : const CustomDayView(),
              ),
            ),
            // CustonWeekView(),
          ],
        ),
      ),
    );
  }

  void _loadEvents() => ref.read(timeVMProvider.notifier).loadEvents().then((i) {
        setState(() {
          _allEvents.addAll(i);
          _eventCtr.addAll(_allEvents);
        });
      });

  void _updateEventController(bool isFilterWorkOrder) {
    final oldEvents = [..._eventCtr.allEvents];
    _eventCtr.removeAll(oldEvents);
    if (isFilterWorkOrder == _isWorkOrder) {
      _eventCtr.addAll(_allEvents);
      setState(() => _isWorkOrder = null);
      return;
    }
    if (isFilterWorkOrder) {
      final workOrder = _allEvents.where((e) => e.event!.type == TimeEntryType.workOrder).toList();
      _eventCtr.addAll(workOrder);
      setState(() => _isWorkOrder = isFilterWorkOrder);
      return;
    }
    // final timeEntrys = _allEvents.where((e) => e.event!.type == TimeEntryType.timeEntry).toList();
    _eventCtr.addAll(_allEvents.where((e) => e.event!.type == TimeEntryType.timeEntry).toList());
    setState(() => _isWorkOrder = isFilterWorkOrder);
    return;
  }
}
