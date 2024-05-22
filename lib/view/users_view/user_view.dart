import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/themes/app_color.dart';
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

class _EmployeeAdministrationState extends ConsumerState<EmployeeAdministration> {
  bool _isAddConsumableOpen = true;
  int editingProjectIndex = -1;

  // final screenWidth = MediaQuery.of(context).size.width;
  // ref.read(customerProjectProvider.notifier).fetchInfos(); //todo: implement api
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SearchLineHeader(title: 'Mitarbeiterverwaltung'),
              _userHeadline(),
              SizedBox(
                height: 2 * 75,
                child: ListView.builder(
                  itemCount: project.length,
                  itemBuilder: (_, index) => RoleRowCard(
                    project[index],
                    isFirst: index == 0,
                    isLast: index == project.length,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 40,
                  width: 40,
                  child: Material(
                    clipBehavior: Clip.antiAlias,
                    color: AppColor.kPrimaryButtonColor,
                    borderRadius: BorderRadius.circular(30),
                    child: InkWell(
                      child: Icon(
                        _isAddConsumableOpen ? Icons.remove : Icons.add,
                        color: Colors.white,
                      ),
                      onTap: () {
                        setState(() {
                          _isAddConsumableOpen = !_isAddConsumableOpen;
                        });
                      },
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: _isAddConsumableOpen,
                child: AddNewEmployee(
                  onSave: () {
                    log('save');
                  },
                  onCancel: () {
                    log('cancel');
                    setState(() {
                      _isAddConsumableOpen = !_isAddConsumableOpen;
                    });
                  },
                  project: editingProjectIndex != -1
                      ? project[editingProjectIndex]
                      : null, //If a project was clicked instead of the + icon, we pass the project and prefill the data
                ),
              )
            ],
          ),
        ),
      );

  Widget _userHeadline() => const Padding(
        padding: EdgeInsets.symmetric(vertical: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 3,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'Name',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Expanded(
                    child: Text(
                      'Rolle',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
      );
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
