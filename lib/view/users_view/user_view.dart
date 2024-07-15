import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/users_models/user_role/user_role.dart';
import '../../provider/user_provider/user_administration/user_administration._provider.dart';
import '../shared_widgets/add_button_widget.dart';
import '../shared_widgets/search_line_header.dart';
import '../shared_widgets/waiting_message_widget.dart';
import 'widgets/edit_employee_widget.dart';
import 'widgets/user_data_widget.dart';
import 'widgets/user_row_headline_widget.dart';

class EmployeeAdministration extends ConsumerStatefulWidget {
  const EmployeeAdministration({super.key});

  @override
  ConsumerState<EmployeeAdministration> createState() => _EmployeeAdministrationState();
}

class _EmployeeAdministrationState extends ConsumerState<EmployeeAdministration> {
  bool _isVisible = false;
  final List<UserRole> _roles = [];
  @override
  void initState() {
    super.initState();
    initAttributes();
  }

  void initAttributes() => ref.read(userAdministrationProvider.notifier).loadUserRoles().then((e) {
        setState(() => _roles.addAll(e));
      });

  @override
  Widget build(BuildContext ctx) => Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SearchLineHeader(title: 'Mitarbeiterverwaltung'),
                    const UserRowHeadLine(),
                    SizedBox(
                      height: 11 * 60,
                      child: ref.watch(userAdministrationProvider).isEmpty
                          ? const WaitingMessageWidget('Lade Mitarbeitende')
                          : ListView.builder(
                              itemCount: ref.watch(userAdministrationProvider).length,
                              itemBuilder: (_, index) => UserDataWidget(
                                key: ValueKey(ref.watch(userAdministrationProvider)[index]),
                                ref.watch(userAdministrationProvider)[index],
                                _roles,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            left: 10,
            child: AddButton(
                isOpen: _isVisible,
                onTap: () => setState(() => _isVisible = !_isVisible),
                hideAbleChild: SizedBox(
                  child: _isVisible ? AddNewEmployee(_roles) : const SizedBox.shrink(),
                )),
          ),
        ],
      );
}
