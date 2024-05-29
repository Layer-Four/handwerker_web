import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/users_models/user_data_short/user_short.dart';
import '../../models/users_models/user_role/user_role.dart';
import '../../provider/user_provider/user_administration/user_administration._provider.dart';
import '../../routes/app_routes.dart';
import '../shared_view_widgets/search_line_header.dart';
import 'widgets/add_button_widget.dart';
import 'widgets/edit_employee_widget.dart';
import 'widgets/user_row_widget.dart';

class EmployeeAdministration extends ConsumerStatefulWidget {
  //StatelessWidget
  const EmployeeAdministration({super.key});

  @override
  ConsumerState<EmployeeAdministration> createState() => _EmployeeAdministrationState();
}

class _EmployeeAdministrationState extends ConsumerState<EmployeeAdministration> {
  bool _isOpen = false;
  final List<UserDataShort> _users = [];
  final List<UserRole> _roles = [];
  @override
  void initState() {
    super.initState();
    initAttributes();
  }

  void initAttributes() {
    ref.read(userAdministrationProvider.notifier).loadUserRoles().then(
      (e) {
        initUsers();
        setState(() => _roles.addAll(e));
      },
    );
  }

  void initUsers() {
    if (ref.watch(userAdministrationProvider).isNotEmpty) {
      final allEntriesAsSet = <UserDataShort>{...ref.watch(userAdministrationProvider), ..._users};
      setState(() => _users.addAll(allEntriesAsSet));
      return;
    }
    ref.read(userAdministrationProvider.notifier).loadUserEntries().then(
      (e) {
        final a = ref.watch(userAdministrationProvider).toSet();
        setState(() => _users.addAll(a.toSet()));
      },
    );
    return;
  }

  @override
  Widget build(BuildContext _) => LayoutBuilder(
      builder: (_, constraints) => SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SearchLineHeader(title: 'Mitarbeiterverwaltung'),
                UserRowHeadLine(constraints),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: SizedBox(
                    height: 5 * 74,
                    child: _users.isEmpty ? _waitingMessage() : _userRowBuilder(constraints),
                  ),
                ),
                // _userRowBuilder(constraints),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AddButton(
                    onTap: () => setState(() => _isOpen = !_isOpen),
                  ),
                ),
                Visibility(
                  visible: _isOpen,
                  child: AddNewEmployee(
                    onCancel: () => setState(() {
                      _isOpen = !_isOpen;
                    }),
                  ),
                )
              ],
            ),
          ));

  Widget _userRowBuilder(BoxConstraints constraints) => ListView.builder(
      itemCount: _users.length,
      itemBuilder: (_, index) => UserRowCard(
            constraints,
            _roles,
            _users[index],
            () {
              _deleteUser(_users[index]);
            },
            isFirst: index == 0,
            isLast: index == _users.length - 1,
          ));

  _deleteUser(UserDataShort user) {
    ref.read(userAdministrationProvider.notifier).deleteUser(user.id).then((e) {
      e
          ? {
              Navigator.of(context).pushReplacementNamed(AppRoutes.viewScreen),
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Mitarbeitenden erfolgreich gelöscht')),
              )
            }
          : ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Mitarbeitenden konnte nicht gelöscht werden')),
            );
    });
  }

  Center _waitingMessage() => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Lade Mitarbeitende',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            const CircularProgressIndicator(),
          ],
        ),
      );
}
