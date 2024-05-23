import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../customer_project_view/custom_project.dart';
import '../shared_view_widgets/search_line_header.dart';
import 'widgets/add_button.dart';
import 'widgets/edit_employee.dart';
import 'widgets/role_row.dart';

class EmployeeAdministration extends ConsumerStatefulWidget {
  //StatelessWidget
  const EmployeeAdministration({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EmployeeAdministrationState createState() => _EmployeeAdministrationState();
}

class _EmployeeAdministrationState extends ConsumerState<EmployeeAdministration> {
  bool _isAddConsumableOpen = false;
  int editingProjectIndex = -1;

  @override
  Widget build(BuildContext _) => LayoutBuilder(
      builder: (_, constraints) => SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SearchLineHeader(title: 'Mitarbeiterverwaltung'),
                _userHeadline(constraints),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: SizedBox(
                    height: 5 * 74,
                    child: ListView.builder(
                      itemCount: project.length,
                      itemBuilder: (_, index) => UserRowCard(
                        constraints,
                        project[index],
                        isFirst: index == 0,
                        isLast: index == project.length - 1,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AddButton(
                    onTap: () => setState(() => _isAddConsumableOpen = !_isAddConsumableOpen),
                  ),
                ),
                Visibility(
                  visible: _isAddConsumableOpen,
                  child: AddNewEmployee(
                    onCancel: () => setState(() {
                      _isAddConsumableOpen = !_isAddConsumableOpen;
                    }),
                    project: editingProjectIndex != -1
                        ? project[editingProjectIndex]
                        : null, //If a project was clicked instead of the + icon, we pass the project and prefill the data
                  ),
                )
              ],
            ),
          ));

  Widget _userHeadline(BoxConstraints constraints) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            SizedBox(
              width: constraints.maxWidth / 10 * 3,
              child: const Text(
                'Name',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              width: constraints.maxWidth / 10 * 3,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Rolle',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
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
