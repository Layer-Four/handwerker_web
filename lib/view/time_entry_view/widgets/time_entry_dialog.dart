import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../models/service_models/service_vm/service_vm.dart';
import '../../../../models/users_models/user_data_short/user_short.dart';
import '../../../../provider/data_provider/service_provider/service_vm_provider.dart';
import '../../../../provider/data_provider/time_entry_provider/time_entry_provider.dart';
import '../../../constants/api/api.dart';
import '../../../constants/themes/app_color.dart';
import '../../../constants/utilitis/utilitis.dart';
import '../../../models/customer_models/customer_short_model/customer_short_dm.dart';
import '../../../models/project_models/project_vm/project_vm.dart';
import '../../../models/time_models/time_vm/time_vm.dart';
import '../../shared_widgets/symetric_button_widget.dart';

class TimeEntryDialog extends ConsumerStatefulWidget {
  const TimeEntryDialog({super.key});
  @override
  ConsumerState<TimeEntryDialog> createState() => _ExecutionState();
}

class _ExecutionState extends ConsumerState<TimeEntryDialog> {
  final TextEditingController _dayPickerController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _endController = TextEditingController();
  final TextEditingController _startController = TextEditingController();
  bool isUserSet = false;
  bool isProjectSet = false;
  TimeOfDay? selectedTime;
  List<UserDataShort>? _users;
  ServiceVM? _choosenService;
  UserDataShort? _selectedUser;
  bool _initUser = false;
  ProjectVM? _project;
  late TimeVMAdapter _entry;
  List<ProjectVM> _projectsFormCustomer = [];
  List<CustomerShortDM> _customers = [];
  CustomerShortDM? _selectedCustomers;

  @override
  void initState() {
    super.initState();
    loadCustomer();
    _entry = TimeVMAdapter(
      date: DateTime.now(),
      startTime: DateTime.now(),
      endTime: DateTime.now(),
    );
    final minute =
        _entry.startTime.minute < 10 ? '0${_entry.startTime.minute}' : '${_entry.startTime.minute}';
    if (selectedTime == null || _dayPickerController.text.isEmpty) {
      _dayPickerController.text =
          '${_entry.startTime.day}.${_entry.startTime.month}.${_entry.startTime.year}';
      selectedTime = TimeOfDay(hour: _entry.startTime.hour, minute: _entry.startTime.minute);
    }
    _startController.text = '${selectedTime!.hour}:$minute';
  }

  void loadCustomer() => ref.read(timeVMProvider.notifier).getAllCustomer().then(
        (e) => setState(() => _customers = e),
      );

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
              const SizedBox(height: 46),
              _submitInput(),
              SizedBox(
                height: 70,
                child: Center(
                  child: Image.asset('assets/images/img_techtool.png', height: 20),
                ),
              ),
            ],
          ),
        ),
      );

  Future<List<UserDataShort>> loadUser() async =>
      await ref.read(timeVMProvider.notifier).getListUserService();

  Widget _buildSelectUser() => FutureBuilder(
        future: loadUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
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
                    'Mitarbeiter',
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
                  'Kunde',
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
                        _entry = _entry.copyWith(
                          customerId: customer.id,
                          customerName: customer.companyName,
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

  Widget _buildProjectField() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                'Projekt',
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
                decoration: InputDecoration(
                  hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppColor.kTextfieldBorder,
                      ),
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
                ),
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

  Widget _buildServiceDropdown() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                'Leistung',
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
                      'Tag',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                  SizedBox(
                    height: 35,
                    width: 200,
                    child: TextField(
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
                      decoration: InputDecoration(
                        hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: AppColor.kTextfieldBorder,
                            ),
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
                      ),
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
                        autofocus: false,
                        controller: _durationController,
                        keyboardType: TextInputType.number,
                        // TODO: implement a wheelspinner for pick Hours and minutes?
                        onChanged: (value) {
                          setState(() {
                            _entry = _entry.copyWith(duration: int.tryParse(value));
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'min.',
                          hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                                color: AppColor.kTextfieldBorder,
                              ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 5,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: AppColor.kTextfieldBorder),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: AppColor.kTextfieldBorder),
                          ),
                        )),
                  ),
                ],
              ),
            )
          ],
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
                    'START',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
                SizedBox(
                  height: 35,
                  width: 200,
                  child: TextField(
                    keyboardType: TextInputType.datetime,
                    autofocus: false,
                    cursorHeight: 20,
                    textInputAction: TextInputAction.next,
                    controller: _startController,
                    decoration: InputDecoration(
                      hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: AppColor.kTextfieldBorder,
                          ),
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
                    ),
                    onTap: () async {
                      final time =
                          await showTimePicker(context: context, initialTime: selectedTime!);
                      if (time != null) {
                        final minute = time.minute < 10 ? '0${time.minute}' : '${time.minute}';
                        _entry = _entry.copyWith(
                            startTime: DateTime(
                          _entry.date.year,
                          _entry.date.month,
                          _entry.date.day,
                          time.hour,
                          time.minute,
                        ));
                        _startController.text = '${time.hour}:$minute';
                      }
                    },
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
                    'BIS',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
                SizedBox(
                  height: 35,
                  width: 200,
                  child: TextField(
                    keyboardType: TextInputType.datetime,
                    autofocus: false,
                    cursorHeight: 20,
                    textInputAction: TextInputAction.done,
                    controller: _endController,
                    decoration: InputDecoration(
                      hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: AppColor.kTextfieldBorder,
                          ),
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
                    ),
                    onTap: () async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay(
                          hour: int.tryParse(_endController.text.split(':').first) ?? 16,
                          minute: int.tryParse(_endController.text.split(':').last) ?? 30,
                        ),
                      );
                      if (time != null) {
                        setState(() {
                          _entry = _entry.copyWith(
                              endTime: DateTime(
                            _entry.date.year,
                            _entry.date.month,
                            _entry.date.day,
                            time.hour,
                            time.minute,
                          ));
                          final minute = time.minute < 10 ? '0${time.minute}' : '${time.minute}';
                          _endController.text = '${time.hour}:$minute';
                        });
                        final sum = Utilitis.calculateDuration(
                            _dayPickerController.text, _startController.text, _endController.text);

                        _durationController.text = Utilitis.buildDurationInHourers(sum);
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      );
  Future getData(Api apo) async {
    final response = await apo.getAllProjects;
    return response.data;
  }

  Widget _submitInput() => Padding(
        padding: const EdgeInsets.all(16.0),
        child: SymmetricButton(
          color: AppColor.kPrimaryButtonColor,
          text: 'Eintrag erstellen',
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
          onPressed: () {
            // TODO: check if _selectetCustomer in _entry!!

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
          },
        ),
      );
}
