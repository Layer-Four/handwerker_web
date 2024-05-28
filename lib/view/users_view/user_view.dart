import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/users_models/user_data_short/user_short.dart';
import '../../models/users_models/user_role/user_role.dart';
import '../../provider/user_provider/user_provider.dart';
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
  final List<UserDataShort> users = [];
  final List<UserRole> _roles = [];
  Future<List<UserDataShort>> loadUserEntries() async {
    final loadedUsers = await ref.read(userProvider.notifier).loadUserEntries();
    setState(() => users.addAll(loadedUsers));
    return loadedUsers;
  }

  void initUserRoles() => ref.read(userProvider.notifier).loadUserRoles().then(
        (e) => setState(
          () => _roles.addAll(e),
        ),
      );

  @override
  void initState() {
    super.initState();
    initUserRoles();
  }

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
                    child: FutureBuilder(
                        future: loadUserEntries(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            const Center(child: Text('Lade Mitarbeitende'));
                          }
                          if (snapshot.connectionState == ConnectionState.done &&
                              snapshot.data == null) {
                            throw Exception('can snapshot be null in userView?');
                          }
                          return ListView.builder(
                            itemCount: users.length,
                            itemBuilder: (_, index) => UserRowCard(
                              constraints,
                              _roles,
                              users[index],
                              isFirst: index == 0,
                              isLast: index == users.length - 1,
                            ),
                          );
                        }),
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
