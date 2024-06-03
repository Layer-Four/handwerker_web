import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/themes/app_color.dart';
import '../../../models/users_models/user_data_short/user_short.dart';
import '../../../models/users_models/user_role/user_role.dart';
import '../../../provider/user_provider/user_administration/user_administration._provider.dart';
import '../../shared_view_widgets/symetric_button_widget.dart';

class UserRowCard extends ConsumerStatefulWidget {
  final BoxConstraints constraints;
  final List<UserRole> possibleRoles;
  final UserRole nullRole;
  final UserDataShort user;
  final bool isFirst;
  final bool isLast;
  final Function() onAccept;

  const UserRowCard(
    this.constraints,
    this.possibleRoles,
    this.user,
    this.onAccept, {
    super.key,
    this.isFirst = false,
    this.isLast = false,
    this.nullRole = const UserRole(id: ' ', name: '', normalizedName: ''),
  });
  @override
  ConsumerState<UserRowCard> createState() => _UserRowCardState();
}

class _UserRowCardState extends ConsumerState<UserRowCard> {
  late final UserDataShort user;
  late final BoxConstraints constraints;
  late final bool isFirst;
  late final bool isLast;
  late final List<UserRole> possibleRoles;
  @override
  void initState() {
    super.initState();
    constraints = widget.constraints;
    isFirst = widget.isFirst;
    isLast = widget.isLast;
    user = widget.user;
    possibleRoles = widget.possibleRoles;
  }

  @override
  Widget build(
    BuildContext context,
  ) =>
      Container(
        height: 75,
        width: constraints.maxWidth,
        decoration: BoxDecoration(
          border: Border(
            top: isFirst ? BorderSide.none : const BorderSide(),
            bottom: isLast ? const BorderSide() : BorderSide.none,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _userDataRow(context),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _deleteButton(context, ref),
                _passwordResetButton(context, ref),
              ],
            ),
          ],
        ),
      );

  Widget buildDropdown({
    required List<UserRole> roleFromUser,
    required List<UserRole> userRoles,
    required ValueChanged onChanged,
    required BuildContext context,
  }) =>
      Container(
        padding: const EdgeInsets.only(left: 8, right: 8),
        decoration: BoxDecoration(
          // border: Border.all(),
          borderRadius: BorderRadius.circular(6),
          color: Colors.grey[100],
        ),
        child: DropdownButton<UserRole?>(
          underline: const SizedBox.shrink(),
          isExpanded: true,
          value: roleFromUser.isEmpty ? null : roleFromUser.first,
          //  userRoles.firstWhere((e) => e.name == roleFromUser.first.name),

          // decoration: InputDecoration(
          //   contentPadding: const EdgeInsets.symmetric(
          //     horizontal: 15,
          //     vertical: 5,
          //   ),
          //   enabledBorder: OutlineInputBorder(
          //     borderRadius: BorderRadius.circular(12),
          //     borderSide: const BorderSide(
          //       color: Color.fromARGB(255, 220, 217, 217),
          //     ),
          //   ),
          //   focusedBorder: OutlineInputBorder(
          //     borderRadius: BorderRadius.circular(12),
          //     borderSide: const BorderSide(color: Color.fromARGB(255, 220, 217, 217)),
          //   ),
          //   filled: true,
          //   fillColor: Colors.grey[100],
          // ),
          onChanged: onChanged,
          items: userRoles
              .map((value) => DropdownMenuItem(
                    onTap: () {
                      // TODO: Update Function to provider Method and update Database
                      final x = user.copyWith(roles: [value]);
                      log(x.toJson().toString());
                      ref
                          .read(userAdministrationProvider.notifier)
                          .updateUser(user.copyWith(roles: [value]))
                          .then((r) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            showCloseIcon: true,
                            content: Text(
                                r ? 'Erfolgreich angepasst' : 'Leider ist etwas schief gegagen'),
                          ),
                        );
                      });
                    },
                    value: value,
                    child: Text(value.name),
                  ))
              .toList(),
        ),
      );

  Widget _deleteButton(BuildContext context, WidgetRef ref) => Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: Container(
          width: 80,
          decoration: BoxDecoration(
              border: Border.all(color: AppColor.kPrimaryButtonColor, width: 1.5),
              borderRadius: BorderRadius.circular(6)),
          child: SymmetricButton(
            onPressed: () {
              _showAskDeletePopUp(
                context,
                onAccept: widget.onAccept,
                onReject: () => Navigator.of(context).pop(),
              );
            },
            borderRadius: BorderRadius.circular(6),
            color: AppColor.kWhite,
            text: 'Löschen',
            overflow: TextOverflow.clip,
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
      );

  Widget _passwordResetButton(BuildContext context, WidgetRef ref) => SizedBox(
        width: MediaQuery.of(context).size.width >= 1100 ? 250 : constraints.maxWidth / 10 * 2.2,
        child: SymmetricButton(
          borderRadius: BorderRadius.circular(6),
          onPressed: () {
            ref.read(userAdministrationProvider.notifier).resetPassword(user.userName).then((e) {
              _showNewPasswordPopUp(context, e);
            });
            log('Password reset for ${user.userName}');
          },
          text: 'Passwort zurücksetzen',
          overflow: TextOverflow.clip,
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
          style: Theme.of(context).textTheme.labelMedium?.copyWith(color: AppColor.kWhite),
        ),
      );

  Future<dynamic> _showAskDeletePopUp(
    BuildContext context, {
    required Function() onAccept,
    required Function() onReject,
  }) =>
      showDialog(
          context: context,
          builder: (context) => Dialog(
                backgroundColor: Colors.white,
                child: SizedBox(
                  height: 350,
                  width: constraints.maxWidth / 10 * 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              'Sind sie sicher, dass sie diesen Mitarbeitenden löschen wollen?',
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20.0),
                                  child: SymmetricButton(
                                    borderRadius: BorderRadius.circular(6),
                                    text: 'Ja',
                                    onPressed: onAccept,
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20.0),
                                  child: SymmetricButton(
                                    borderRadius: BorderRadius.circular(6),
                                    text: 'Nein',
                                    onPressed: onReject,
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ));

  Future<dynamic> _showNewPasswordPopUp(BuildContext context, Map<dynamic, dynamic> e) =>
      showDialog(
          context: context,
          builder: (context) => Dialog(
                backgroundColor: Colors.white,
                child: SizedBox(
                  height: 250,
                  width: 250,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              'Mitarbeiter:',
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                '   ${e['userName']}',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          children: [
                            Text(
                              'Passwort:',
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                '     ${e['password']}',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ));

  Widget _userDataRow(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: constraints.maxWidth / 100 * 20,
            child: Text(
              user.userName,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              overflow: TextOverflow.fade,
            ),
          ),
          SizedBox(
            height: 40,
            width: constraints.maxWidth / 100 * 20,
            child: buildDropdown(
                roleFromUser: user.roles,
                userRoles: possibleRoles,
                onChanged: (_) {
                  // setState(() {
                  //   _selectedRole = value;
                  // });
                },
                context: context),
          ),
        ],
      );
}

class UserRowHeadLine extends StatelessWidget {
  final BoxConstraints constraints;
  const UserRowHeadLine(
    this.constraints, {
    super.key,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            SizedBox(
              width: constraints.maxWidth / 10 * 2,
              child: const Text(
                'Name',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              width: constraints.maxWidth / 10 * 2,
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
