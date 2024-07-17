import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/service_models/service_vm/service_vm.dart';
import '../../../../models/users_models/user_data_short/user_short.dart';
import '../../../../provider/data_provider/service_provider/service_vm_provider.dart';
import '../../../../provider/data_provider/time_entry_provider/time_entry_provider.dart';
import '../../../constants/themes/app_color.dart';
import '../../../constants/utilitis/utilitis.dart';
import '../../../models/customer_models/customer_short_model/customer_short_dm.dart';
import '../../../models/project_models/project_short_vm/project_short_vm.dart';
import '../../../models/time_models/time_vm/time_vm.dart';
import '../../shared_widgets/error_message_widget.dart';
import '../../shared_widgets/symetric_button_widget.dart';

class TimeEntryDialog extends ConsumerStatefulWidget {
  const TimeEntryDialog({super.key});
  @override
  ConsumerState<TimeEntryDialog> createState() => _TimeEntryDialogState();
}

class _TimeEntryDialogState extends ConsumerState<TimeEntryDialog> {
  late final TextEditingController _dayPickerController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _durationController;
  late final TextEditingController _endController;
  late final TextEditingController _startController;
  TimeOfDay? _selectedTime;
  List<UserDataShort>? _users;
  ServiceVM? _choosenService;
  UserDataShort? _selectedUser;
  bool _initUser = false;
  ProjectShortVM? _project;
  late TimeVMAdapter _entry;
  List<ProjectShortVM> _projectsFormCustomer = [];
  List<CustomerShortDM> _customers = [];
  CustomerShortDM? _selectedCustomers;

  @override
  void initState() {
    final DateTime now = DateTime.now();
    loadCustomer();
    _entry = TimeVMAdapter(
      date: now,
      startTime: now,
      endTime: now,
    );
    final minute =
        _entry.startTime.minute < 10 ? '0${_entry.startTime.minute}' : '${_entry.startTime.minute}';
    _dayPickerController = TextEditingController(
        text: '${_entry.startTime.day}.${_entry.startTime.month}.${_entry.startTime.year}');
    _descriptionController = TextEditingController();
    _durationController = TextEditingController();
    _endController = TextEditingController();
    _startController = TextEditingController(text: '${_selectedTime!.hour}:$minute');
    _selectedTime ??= TimeOfDay(hour: _entry.startTime.hour, minute: _entry.startTime.minute);
    super.initState();
  }

  @override
  void dispose() {
    _dayPickerController.dispose();
    _descriptionController.dispose();
    _durationController.dispose();
    _endController.dispose();
    _startController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _dayInputRow(),
              _timeInputRow(),
              _buildCustomerDropDown(),
              _buildProjectField(),
              _buildServiceDropdown(),
              _buildDescription(),
              _buildSelectUser(),
              _submitInput(),
              Center(
                child: Image.asset('assets/images/img_techtool.png', height: 20),
              ),
            ],
          ),
        ),
      );

  void loadCustomer() => ref.read(timeVMProvider.notifier).getAllCustomer().then(
        (e) => setState(() => _customers = e),
      );

  Future<List<UserDataShort>> loadUser() async =>
      await ref.read(timeVMProvider.notifier).getListUserService();

  Widget _buildCustomerDropDown() => GestureDetector(
        onTap: (() => _customers.isEmpty ? loadCustomer() : null),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  'Kunde*',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
              Container(
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColor.kTextfieldBorder),
                ),
                child: DropdownButton(
                  underline: const SizedBox(),
                  isExpanded: true,
                  value: _selectedCustomers,
                  items: _customers
                      .map(
                        (customer) => DropdownMenuItem(
                          value: customer,
                          child: Text(customer.companyName),
                        ),
                      )
                      .toList(),
                  onChanged: (customer) {
                    ref.read(timeVMProvider.notifier).getProjectForCustomer(customer!.id).then((e) {
                      setState(() {
                        _selectedCustomers = customer;
                        _projectsFormCustomer = e.toSet().toList();
                        _project =
                            _projectsFormCustomer.isEmpty ? null : _projectsFormCustomer.last;
                        _entry = _entry.copyWith(
                          customerId: customer.id,
                          customerName: customer.companyName,
                          project: _project,
                        );
                      });
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      );

  Padding _buildDescription() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                'Beschreibung',
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
            SizedBox(
              height: 80,
              child: TextField(
                cursorHeight: 20,
                controller: _descriptionController,
                textAlignVertical: TextAlignVertical.top,
                expands: true,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                maxLines: null,
                decoration: timeEntryTextFieldDecoration(),
                onChanged: (value) {
                  setState(() {
                    TextSelection previousSelection = _descriptionController.selection;
                    _descriptionController.text = value;
                    _descriptionController.selection = previousSelection;
                    _entry = _entry.copyWith(description: _descriptionController.text);
                  });
                },
              ),
            ),
          ],
        ),
      );

  Widget _buildProjectField() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                'Projekt*',
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
            Container(
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColor.kTextfieldBorder),
              ),
              child: DropdownButton(
                underline: const SizedBox(),
                isExpanded: true,
                value: _project,
                items: _projectsFormCustomer
                    .map(
                      (project) => DropdownMenuItem(
                        value: project,
                        child: Text(project.title ?? 'Kein Title'),
                      ),
                    )
                    .toList(),
                onChanged: (project) {
                  setState(() {
                    _project = project;
                    _entry = _entry.copyWith(project: project);
                  });
                },
              ),
            ),
          ],
        ),
      );

  Widget _buildSelectUser() => FutureBuilder(
        future: loadUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
            if (!_initUser) {
              _users = snapshot.data;
              _selectedUser = _users!.first;
              _initUser = true;
              _entry = _entry.copyWith(user: _selectedUser);
            }
          }
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    'Mitarbeiter*',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColor.kTextfieldBorder),
                  ),
                  child: DropdownButton(
                    menuMaxHeight: 300,
                    underline: const SizedBox(),
                    isExpanded: true,
                    value: _selectedUser,
                    items: _users
                        ?.map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(' ${e.userName}'),
                          ),
                        )
                        .toList(),
                    onChanged: (e) => setState(() {
                      _selectedUser = e!;
                      _entry = _entry.copyWith(user: e);
                    }),
                    onTap: () => (_users == null) ? loadUser() : null,
                  ),
                ),
              ],
            ),
          );
        },
      );

  Widget _buildServiceDropdown() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                'Leistung*',
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
            Container(
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColor.kTextfieldBorder),
              ),
              child: DropdownButton(
                underline: const SizedBox(),
                isExpanded: true,
                value: _choosenService,
                items: ref
                    .watch(serviceVMProvider)
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(' ${e.name}'),
                      ),
                    )
                    .toList(),
                onChanged: (e) => setState(() {
                  _choosenService = e;
                  _entry = _entry.copyWith(service: e);
                }),
              ),
            ),
          ],
        ),
      );

  _dayInputRow() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      'Tag*',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                  SizedBox(
                    height: 35,
                    width: 200,
                    child: TextField(
                      readOnly: true,
                      controller: _dayPickerController,
                      cursorHeight: 20,
                      autofocus: false,
                      keyboardType: TextInputType.datetime,
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2023),
                          lastDate: DateTime(2100),
                        );
                        if (date != null) {
                          setState(() {
                            _entry = _entry.copyWith(date: date);
                            _dayPickerController.text = '${date.day}.${date.month}.${date.year}';
                          });
                        }
                      },
                      decoration: timeEntryTextFieldDecoration(),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      'DAUER',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                  SizedBox(
                    height: 35,
                    width: 200,
                    child: TextField(
                      cursorHeight: 20,
                      controller: _durationController,
                      readOnly: true,
                      decoration: timeEntryTextFieldDecoration(hint: 'min'),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );

  Widget _submitInput() => Padding(
        padding: const EdgeInsets.all(32.0),
        child: SymmetricButton(
          color: AppColor.kPrimaryButtonColor,
          text: 'Eintrag erstellen',
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
          onPressed: () => _submit(),
        ),
      );

  Widget _timeInputRow() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    'START*',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
                SizedBox(
                  height: 35,
                  width: 200,
                  child: TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^[\d:]{0,5}')),
                    ],
                    keyboardType: TextInputType.datetime,
                    cursorHeight: 20,
                    controller: _startController,
                    decoration: timeEntryTextFieldDecoration(),
                    onTap: () => _selectStartTime(),
                    onTapOutside: (event) => setState(() {
                      final result = _checkIfTimeFormat(_startController.text);
                      _startController.text = result.isEmpty ? _startController.text : result;
                      if (_endController.text.isNotEmpty) {
                        _calculateDuration();
                      }
                    }),
                    onEditingComplete: () => setState(() {
                      final result = _checkIfTimeFormat(_startController.text);
                      _startController.text = result.isEmpty ? _startController.text : result;
                      if (_endController.text.isNotEmpty) {
                        _calculateDuration();
                      }
                    }),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    'BIS*',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
                SizedBox(
                  height: 35,
                  width: 200,
                  child: TextField(
                    onTapOutside: (event) => setState(() {
                      final result = _checkIfTimeFormat(_endController.text);
                      _endController.text = result.isEmpty ? _endController.text : result;
                      _calculateDuration();
                    }),
                    onEditingComplete: () => setState(() {
                      // _endController.text = _checkIfTimeFormat(_endController.text);
                      final result = _checkIfTimeFormat(_endController.text);
                      _endController.text = result.isEmpty ? _endController.text : result;
                      _calculateDuration();
                    }),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^[\d:]{0,5}')),
                      // FilteringTextInputFormatter.allow(RegExp(r'^[0-2]?[0-9]?:?[0-5]?[0-9]?$')),
                      // FilteringTextInputFormatter.allow(
                      //     RegExp(r'^([01]?[0-9]|2[0-3]):[0-5]?[0-9]$')),
                    ],
                    autofocus: false,
                    cursorHeight: 20,
                    textInputAction: TextInputAction.next,
                    controller: _endController,
                    decoration: timeEntryTextFieldDecoration(),
                    onTap: () => _selectEndTime(),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
  void _selectStartTime() async {
    final date = _entry.date;
    final initialTime = DateTime(
      date.year,
      date.month,
      date.day,
      int.tryParse(_startController.text.split(':').first) ?? DateTime.now().hour,
      int.tryParse(_startController.text.split(':').last) ?? DateTime.now().minute,
    );
    final time = await Utilitis.showTimeSpinner(context, initialTime);
    if (time == null) return;
    final timeAsList = time.split(':');
    final hour = int.parse(timeAsList.first);
    final minute = int.parse(timeAsList.last);

    DateTime startDate = DateTime(date.year, date.month, date.day, hour, minute);

    final minuteString = startDate.minute < 10 ? '0${startDate.minute}' : '${startDate.minute}';

    setState(() {
      _entry = _entry.copyWith(startTime: startDate);
      _startController.text = '${_entry.startTime.hour}:$minuteString';
    });
    return;
  }

  void _selectEndTime() async {
    final date = _entry.date;
    final initialTime = DateTime(
      date.year,
      date.month,
      date.day,
      int.tryParse(_endController.text.split(':').first) ?? 16,
      int.tryParse(_endController.text.split(':').last) ?? 30,
    );
    final time = await Utilitis.showTimeSpinner(context, initialTime);
    if (time == null) return;
    final timeAsList = time.split(':');
    final hour = int.parse(timeAsList.first);
    final minute = int.parse(timeAsList.last);

    DateTime endDate = DateTime(date.year, date.month, date.day, hour, minute);
    final startDate = DateTime(
      date.year,
      date.month,
      date.day,
      int.tryParse(_startController.text.split(':').first) ?? 0,
      int.tryParse(_startController.text.split(':').last) ?? 0,
    );
    if (endDate.millisecondsSinceEpoch < startDate.millisecondsSinceEpoch) {
      endDate = startDate;
    }
    final minuteString = endDate.minute < 10 ? '0${endDate.minute}' : '${endDate.minute}';
    setState(() {
      _entry = _entry.copyWith(endTime: endDate);
      _endController.text = '${_entry.endTime.hour}:$minuteString';
    });
    _calculateDuration();
    return;
  }

  void _submit() {
    if (_dayPickerController.text.isEmpty ||
        _startController.text.isEmpty ||
        _endController.text.isEmpty ||
        _durationController.text.isEmpty ||
        _selectedCustomers == null ||
        _choosenService == null ||
        _project == null ||
        _selectedUser == null) {
      showDialog(
        context: context,
        builder: (context) =>
            const ErrorMessageWidget('Bitte füllen alle mit * Markierten Felder aus'),
      );

      return;
    }
    ref.read(timeVMProvider.notifier).saveTimeEntry(_entry).then((e) {
      Navigator.of(context).pop();
      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Center(
            child: Text(e ? 'Eintrag wurde erstellt' : 'Leider ist etwas schief gegangen'),
          ),
        ),
      );
    });
  }

  InputDecoration timeEntryTextFieldDecoration({String? hint}) => InputDecoration(
        hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: AppColor.kTextfieldBorder,
            ),
        hintText: hint,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 5,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColor.kTextfieldBorder,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColor.kTextfieldBorder),
        ),
      );
  String _checkIfTimeFormat(String timeString) {
    final regex = RegExp(r'^([01]?[0-9]|2[0-3]):[0-5]?[0-9]$');
    if (!regex.hasMatch(timeString)) {
      showDialog(
        context: context,
        builder: (context) => const ErrorMessageWidget('Keine Gültige Uhrzeit'),
      );
      return '';
    }
    return timeString;
  }

  _calculateDuration() {
    final dateAsList = _dayPickerController.text.split('.').map((e) => int.parse(e)).toList();
    final start = DateTime(
      dateAsList[2],
      dateAsList[1],
      dateAsList[0],
      int.parse(_startController.text.split(':').first),
      int.parse(_startController.text.split(':').last),
    );
    if (!_endController.text.contains(':')) {
      final x = _endController.text;
      setState(() {
        _endController.text = '${x[0]}${x[1]}:${x.substring(2).isEmpty ? '00' : x.substring(2)}';
      });
    }
    final timeList = _endController.text.split(':');
    DateTime end = DateTime(
      dateAsList[2],
      dateAsList[1],
      dateAsList[0],
      int.parse(_endController.text.split(':').first),
      int.parse(timeList.length > 1 ? _endController.text.split(':').last : '00'),
    );
    if (end.millisecondsSinceEpoch < start.millisecondsSinceEpoch) {
      end = start;
      setState(() =>
          _endController.text = '${end.hour}:${end.minute < 10 ? '0${end.minute}' : end.minute}');
    }
    final sum = ((end.millisecondsSinceEpoch - start.millisecondsSinceEpoch) / 1000) ~/ 60;
    setState(() {
      _entry = _entry.copyWith(duration: sum);
      _durationController.text = Utilitis.buildDurationInHourers(sum);
    });
  }
}
