import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../../../constants/api/api.dart';
import '../../../../models/service_models/service_vm/service_vm.dart';
import '../../../../models/time_models/time_dm/time_dm.dart';
import '../../../../models/users_models/user_data_short/user_short.dart';
import '../../../../provider/data_provider/service_provider/service_vm_provider.dart';
import '../../../../provider/data_provider/time_entry_provider/time_entry_provider.dart';
import '../../../../provider/user_provider/user_provider.dart';
import '../../shared_view_widgets/symetric_button_widget.dart';

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
  bool initServices = false;
  bool isUserSet = false;
  bool isProjectSet = false;
  TimeOfDay? selectedTime;
  List<UserDataShort>? _users;
  ServiceVM? _choosenService;
  UserDataShort? _selectedUser;
  bool _initUser = false;
  Project? _project;
  late TimeEntry _entry;
  List<Project>? _projectsForCustomer;
  int? _selectedCustomerId;

  @override
  void initState() {
    super.initState();
    _entry = TimeEntry(
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

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _dayInputRow(),
              _timeInputRow(),
              _buildCustomerField(),
              _buildProjectField(_projectsForCustomer ?? []), // Pass projects here
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
      await ref.read(userProvider.notifier).getListUserService();

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
              _entry = _entry.copyWith(userID: _selectedUser!.id);
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
                    border: Border.all(color: const Color.fromARGB(255, 220, 217, 217)),
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
                      _entry = _entry.copyWith(userID: e.id);
                    }),
                    onTap: () => (_users == null) ? loadUser() : () => null,
                  ),
                ),
              ],
            ),
          );
        },
      );

  Widget _buildCustomerField() => FutureBuilder<List<Customer>>(
        future: fetchCustomers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator.adaptive();
          }
          if (snapshot.hasError) {
            return const Text('Error fetching customers');
          }
          final customers = snapshot.data!;
          return _buildCustomerDropdown(customers);
        },
      );

  Widget _buildCustomerDropdown(List<Customer> customers) => Padding(
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
                border: Border.all(color: const Color.fromARGB(255, 220, 217, 217)),
              ),
              child: DropdownButton<int>(
                underline: const SizedBox(),
                isExpanded: true,
                value: _selectedCustomerId,
                items: customers
                    .map(
                      (customer) => DropdownMenuItem<int>(
                        value: customer.id,
                        child: Text(customer.companyName ?? 'Unknown Company'),
                      ),
                    )
                    .toList(),
                onChanged: (customerId) {
                  setState(() {
                    _selectedCustomerId = customerId;
                    final selectedCustomer = customers.firstWhere(
                      (customer) => customer.id == customerId,
                      orElse: () => Customer(companyName: null, id: -1),
                    );
                    // Call _fetchProjectsForCustomer with the selected customer ID
                    _fetchProjectsForCustomer(selectedCustomer.id);
                  });
                },
              ),
            ),
          ],
        ),
      );

  Widget _buildProjectField(List<Project> projects) {
    if (_project == null && projects.isNotEmpty) {
      _project = projects.first;
    }

    return Padding(
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
              border: Border.all(color: const Color.fromARGB(255, 220, 217, 217)),
            ),
            child: DropdownButton<Project>(
              underline: const SizedBox(),
              isExpanded: true,
              value: _project,
              items: projects
                  .map(
                    (project) => DropdownMenuItem<Project>(
                      value: project,
                      child: Text(project.title ?? 'Default Title'),
                    ),
                  )
                  .toList(),
              onChanged: (project) {
                setState(() {
                  _project = project;
                  _entry = _entry.copyWith(projectID: project!.id);
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<List<Customer>> fetchCustomers() async {
    try {
      final response =
          await http.get(Uri.parse('https://r-wa-happ-be.azurewebsites.net/api/customer/list'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => Customer.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load customers');
      }
    } catch (e) {
      throw Exception('Failed to load customers: $e');
    }
  }

  Future<void> _fetchProjectsForCustomer(int customerId) async {
    try {
      final response = await http.get(Uri.parse(
          'https://r-wa-happ-be.azurewebsites.net/api/project/list?customerId=$customerId'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        final projects = jsonList.map((json) => Project.fromJson(json)).toList();

        // Ensure uniqueness using a Set
        final uniqueProjects = projects.toSet().toList();

        setState(() {
          _projectsForCustomer = uniqueProjects;
          _project = projects.isNotEmpty ? projects.first : null;
        });
      } else {
        throw Exception('Failed to load projects for customer');
      }
    } catch (e) {
      throw Exception('Failed to load projects for customer: $e');
    }
  }

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
                        color: const Color.fromARGB(255, 220, 217, 217),
                      ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 5,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 220, 217, 217),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color.fromARGB(255, 220, 217, 217)),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _descriptionController.text = value;
                    _entry = _entry.copyWith(description: _descriptionController.text);
                  });
                },
              ),
            ),
          ],
        ),
      );

  Widget _buildServiceDropdown() => ref.watch(serviceVMProvider).when(
        loading: () => const CircularProgressIndicator.adaptive(),
        error: (error, stackTrace) => const SizedBox(),
        data: (data) {
          if (data == null) {
            ref.watch(serviceVMProvider.notifier).loadServices();
          }
          final services = data;
          if (services != null && !initServices) {
            setState(() {
              _choosenService = services.first;
              _entry = _entry.copyWith(
                serviceID: services.first.id,
                // serviceTitle: services.first.name,
              );
              initServices = true;
            });
          }
          return Padding(
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
                    border: Border.all(color: const Color.fromARGB(255, 220, 217, 217)),
                  ),
                  child: DropdownButton(
                    underline: const SizedBox(),
                    isExpanded: true,
                    value: _choosenService,
                    items: services
                        ?.map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(' ${e.name}'),
                          ),
                        )
                        .toList(),
                    onChanged: (e) => setState(() {
                      _choosenService = e;
                      _entry = _entry.copyWith(
                        // serviceTitle: e!.name,
                        serviceID: e!.id,
                      );
                    }),
                  ),
                ),
              ],
            ),
          );
        },
      );

  /// Split the [String] values from the TextEdingController with the given
  /// format and build [DateTime] objects with the Compination from
  /// _dayPickerController and _startController.
  /// than do  the same translation with _dayPickerController and _endController
  /// and return the different between this [DateTime] object in minutes.
  void _calculateDuration() {
    final dateAsList = _dayPickerController.text.split('.').map((e) => int.parse(e)).toList();
    final start = DateTime(
      dateAsList[2],
      dateAsList[1],
      dateAsList[0],
      int.parse(_startController.text.split(':').first),
      int.parse(_startController.text.split(':').last),
    );
    final end = DateTime(
      start.year,
      start.month,
      start.day,
      int.parse(_endController.text.split(':').first),
      int.parse(_endController.text.split(':').last),
    );
    final sum = ((end.millisecondsSinceEpoch - start.millisecondsSinceEpoch) / 1000) ~/ 60;
    setState(() {
      _entry = _entry.copyWith(duration: sum);
    });
    final hours = sum ~/ 60;
    final minutes = sum % 60;
    // TODO: exclude pause?
    _durationController.text = '$hours:${minutes < 10 ? '0$minutes' : minutes} h.';
  }

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
                              color: const Color.fromARGB(255, 220, 217, 217),
                            ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 5,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 220, 217, 217),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Color.fromARGB(255, 220, 217, 217)),
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
                                color: const Color.fromARGB(255, 220, 217, 217),
                              ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 5,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(255, 220, 217, 217),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Color.fromARGB(255, 220, 217, 217)),
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
                            color: const Color.fromARGB(255, 220, 217, 217),
                          ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 5,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 220, 217, 217),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color.fromARGB(255, 220, 217, 217)),
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
                            color: const Color.fromARGB(255, 220, 217, 217),
                          ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 5,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 220, 217, 217),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color.fromARGB(255, 220, 217, 217)),
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
                        _calculateDuration();
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
    log('Attempt to call api');
    final response = await apo.getAllProjects;
    log('Done calling api');
    log(response.statusMessage.toString());
    log(response.statusCode.toString());
    log(response.data.toString());
    return response.data;
  }

  Widget _submitInput() => Padding(
        padding: const EdgeInsets.all(16.0),
        child: SymmetricButton(
          color: Colors.orange,
          text: 'Eintrag erstellen',
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
          onPressed: () {
            ref.read(timeVMProvider.notifier).saveTimeEntry(_entry);
            // TODO: uncommand this, after API is ready           ref.read(timeEntryProvider.notifier).uploadTimeEntry(_entry);
            Navigator.of(context).pop();
            // if (_startController.text.isEmpty || _endController.text.isEmpty) {
            //   return ScaffoldMessenger.of(context).showSnackBar(
            //     const SnackBar(
            //       content: Text('Bitte wählen sie Start- und Endzeit'),
            //     ),
            //   );
            // } else {
            // final data = _entry.toJson();
            // log(json.encode(data));
            // ref.read(timeEntryVMProvider.notifier).uploadTimeEntry(_entry);
            //   final now = DateTime.now();
            //   setState(() {
            //     _startController.clear();
            //     _descriptionController.clear();
            //     _endController.clear();
            //     _durationController.clear();
            //     _dayPickerController.text = '${now.day}.${now.month}.${now.year}';
            //   });
            return ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Center(child: Text('Vorsicht Lügner!')),
              ),
            );
            // }
          },
        ),
      );
}
// class