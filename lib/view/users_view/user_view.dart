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
  final List<UserRole> _roles = [];
  @override
  void initState() {
    super.initState();
    initAttributes();
  }

  void initAttributes() {
    ref.read(userAdministrationProvider.notifier).loadUserRoles().then(
      (e) {
        setState(() => _roles.addAll(e));
      },
    );
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
                    child: ref.watch(userAdministrationProvider).isEmpty
                        ? _waitingMessage()
                        : _userRowBuilder(constraints),
                  ),
                ),
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
                    onSave: () {},
                  ),
                )
              ],
            ),
          ));

  Widget _userRowBuilder(BoxConstraints constraints) => ListView.builder(
      itemCount: ref.watch(userAdministrationProvider).length,
      itemBuilder: (_, index) => UserRowCard(
            constraints,
            _roles,
            ref.watch(userAdministrationProvider)[index],
            () {
              _deleteUser(ref.watch(userAdministrationProvider)[index]);
            },
            isFirst: index == 0,
            isLast: index == ref.watch(userAdministrationProvider).length - 1,
          ));

  _deleteUser(UserDataShort user) {
    ref.read(userAdministrationProvider.notifier).deleteUser(user.id).then((e) {
      e
          ? {
              Navigator.of(context).pop(),
              Navigator.of(context).pushReplacementNamed(AppRoutes.viewScreen),
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Mitarbeitenden erfolgreich gelöscht')),
              )
            }
          : {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Mitarbeitenden konnte nicht gelöscht werden')),
              ),
              Navigator.of(context).pop(),
            };
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
