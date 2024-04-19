import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:handwerker_web/view/users_view/role_row.dart';
import '../customer_project_view/custom_project.dart';
import 'edit_employee.dart';
import '../shared_view_widgets/search_line_header.dart';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/constants/api/api.dart';
import '/models/project_models/project_vm/project_vm.dart';
import '/models/service_models/service_vm/service_vm.dart';
import '/models/time_models/time_dm/time_dm.dart';
import '/models/users_models/user_data_short/user_short.dart';
import '/provider/data_provider/project_provders/project_vm_provider.dart';
import '/provider/data_provider/service_provider/service_vm_provider.dart';
import '/provider/data_provider/time_entry_provider/time_entry_provider.dart';
import '/provider/user_provider/user_provider.dart';

class EmployeeAdministration extends ConsumerStatefulWidget {
  //StatelessWidget
  const EmployeeAdministration({super.key});

  @override
  _EmployeeAdministrationState createState() => _EmployeeAdministrationState();
}

class _EmployeeAdministrationState extends ConsumerState<EmployeeAdministration> {
  //Call fetch infos here

  //  const Text('Berichte', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
  bool isAddConsumableOpen = false;
  int editingProjectIndex = -1;

  @override
  Widget build(BuildContext context) {
    //, WidgetRef ref
    final screenWidth = MediaQuery.of(context).size.width;
    //ref.read(customerProjectProvider.notifier).fetchInfos(); //todo: implement api

/*    late List<TextEditingController> _controllers;
    late List<bool> _isEditing;

    void _addNewConsumable() {
      setState(() {
        final newController = TextEditingController();
        _controllers.add(newController);
        _isEditing.add(true);
      });
    }*/

    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(75, 30, 65, 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SearchLineHeader(title: 'Kundenverwaltung'),
              const SizedBox(
                height: 60,
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Name',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    Text(
                      'Rolle',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: screenWidth > 600 ? double.infinity : null,
                height: MediaQuery.of(context).size.height / 2 - 100,
                /*isAddConsumableOpen
                    ? MediaQuery.of(context).size.height / 3
                    : MediaQuery.of(context).size.height - 300,*/
                child: ListView.builder(
                  itemCount: project.length,
                  itemBuilder:
                      (_, index) => /*GestureDetector(
                    onTap: () {
                      setState(() {
                        isAddConsumableOpen = !isAddConsumableOpen;
                        editingProjectIndex = index;
                      });
                    },
                    child:*/
                          RoleRowCard(
                    project[index],
                    isFirst: index == 0,
                    isLast: index == project.length,
                  ),
                  //       ),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: SizedBox(
                    height: 30,
                    width: 30,
                    child: Material(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(50),
                      child: Center(
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: Icon(
                            isAddConsumableOpen ? Icons.remove : Icons.add,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              isAddConsumableOpen = !isAddConsumableOpen;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: isAddConsumableOpen,
                child: Container(
                  // alignment: Alignment.topLeft,
                  height: MediaQuery.of(context).size.height / 3,
                  width: screenWidth / 2,
                  child: AddNewEmployee(
                    onSave: () {
                      print('save');
                      //Todo: Call api for saving
                      //If Edit was clicked (therefore index != -1), also pass which customer is to be edited
                      //Might be a different apie then
                      /*                  setState(() {
                        _addNewConsumable();
                      });*/
                    },
                    onCancel: () {
                      print('cancel');
                      setState(() {
                        isAddConsumableOpen = !isAddConsumableOpen;
                      });
                    },
                    project: editingProjectIndex != -1
                        ? project[editingProjectIndex]
                        : null, //If a project was clicked instead of the + icon, we pass the project and prefill the data
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

final List<CustomeProject> project = [
  const CustomeProject(
    'Kunde X',
    'Austausch der\nHeizungsanlage',
    false,
    60000,
    11,
    '01.01.2024 - 01.06.2025',
    1009,
    1009,
  ),
  const CustomeProject(
    'Kunde Y',
    'Tisch gebaut',
    true,
    20000,
    11,
    '01.01.2024 - 01.06.2025',
    2099,
    9000,
  ),
  const CustomeProject(
    'Kunde XY',
    'Fenster eingesetzt',
    true,
    20000,
    11,
    '01.01.2024 - 01.06.2025',
    2,
    900000,
  ),
  const CustomeProject(
    'Fio Bestmann',
    'Steinloch 43\n22880, Hamburg',
    true,
    20000,
    2,
    '01.01.2024 - 01.06.2025',
    2,
    1009,
  ),
  const CustomeProject(
    'Florian hensel',
    'große Straße 54\n22449, Kassel',
    true,
    20.000,
    2,
    '01.01.2024 - 01.06.2025',
    2,
    122000,
  ),
];
