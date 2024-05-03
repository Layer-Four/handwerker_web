import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../customer_project_view/custom_project.dart';
import '../shared_view_widgets/search_line_header.dart';
import 'edit_employee.dart';
import 'role_row.dart';

class EmployeeAdministration extends ConsumerStatefulWidget {
  //StatelessWidget
  const EmployeeAdministration({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EmployeeAdministrationState createState() => _EmployeeAdministrationState();
}

class _EmployeeAdministrationState
    extends ConsumerState<EmployeeAdministration> {
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
              const SearchLineHeader(title: 'Mitarbeiterverwaltung'),
              const SizedBox(
                height: 60,
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Expanded(
                      //Expandeds here to make sure the headers are aligned with the context below
                      flex: 3,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              'Name',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          Expanded(
                            child: Text(
                              'Rolle',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(flex: 3, child: SizedBox()),
                    Expanded(
                        flex: 1,
                        child: Text(
                          '',
                        )),
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
                child: SizedBox(
                  // alignment: Alignment.topLeft,
                  height: MediaQuery.of(context).size.height / 3,
                  width: screenWidth / 2,
                  child: AddNewEmployee(
                    onSave: () {
                      // ignore: avoid_print
                      print('save');
                      //Todo: Call api for saving
                      //If Edit was clicked (therefore index != -1), also pass which customer is to be edited
                      //Might be a different apie then
                      /*                  setState(() {
                        _addNewConsumable();
                      });*/
                    },
                    onCancel: () {
                      // ignore: avoid_print
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
    'Oliver P.',
    'Reperatur Schaltung',
    false,
    50,
    11,
    '01.01.2024 - 01.06.2025',
    1009,
    1009,
  ),
  const CustomeProject(
    'Michael M.',
    'Installation Beleuchtung',
    true,
    60,
    11,
    '01.01.2024 - 01.06.2025',
    2099,
    9000,
  ),
  const CustomeProject(
    'Tina S.',
    'Reperatur Wasserleitung',
    true,
    70,
    11,
    '01.01.2024 - 01.06.2025',
    2,
    900000,
  ),
  const CustomeProject(
    'Matthias R.',
    'Behebung Leckage',
    true,
    60,
    2,
    '01.01.2024 - 01.06.2025',
    2,
    1009,
  ),
  const CustomeProject(
    'Praktikant 1',
    'Anstrich Innenwand',
    true,
    70,
    2,
    '01.01.2024 - 01.06.2025',
    2,
    122000,
  ),
];
