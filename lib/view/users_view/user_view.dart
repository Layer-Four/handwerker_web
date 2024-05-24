import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/users_models/user_role/user_role.dart';
import '../shared_view_widgets/search_line_header.dart';
import 'widgets/add_button.dart';
import 'widgets/edit_employee.dart';
import 'widgets/role_row.dart';

class EmployeeAdministration extends ConsumerStatefulWidget {
  //StatelessWidget
  const EmployeeAdministration({super.key});

  @override
  ConsumerState<EmployeeAdministration> createState() => _EmployeeAdministrationState();
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
                      itemCount: users.length,
                      itemBuilder: (_, index) => UserRowCard(
                        constraints,
                        users[index],
                        isFirst: index == 0,
                        isLast: index == users.length - 1,
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
                        ? users[editingProjectIndex]
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

class UserEntry {
  final String name;
  final List<UserRole> role;
  const UserEntry(
    this.name, [
    this.role = const [UserRole(name: 'Mobil')],
  ]);
  UserEntry copyWith({
    String? name,
    List<UserRole>? role,
  }) =>
      UserEntry(
        name ?? this.name,
        role ?? this.role,
      );
  toList() => [this];
}

final List<UserEntry> users = [
  const UserEntry('Oliver P.'),
  const UserEntry('Michale M.', [
    UserRole(name: 'Web'),
    UserRole(name: 'Mobile'),
  ]),
  const UserEntry('Tina S.'),
  const UserEntry('Matthias R.'),
  const UserEntry('Praktikant 1.'),
];
