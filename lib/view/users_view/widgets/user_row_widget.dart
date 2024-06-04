import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/themes/app_color.dart';
import '../../../constants/utilitis/utilitis.dart';
import '../../../models/users_models/user_data_short/user_short.dart';
import '../../../models/users_models/user_role/user_role.dart';
import '../../../provider/user_provider/user_administration/user_administration._provider.dart';
import '../../shared_view_widgets/symetric_button_widget.dart';

class UserRowCard extends ConsumerWidget {
  final List<UserRole> possibleRoles;
  final UserRole nullRole;
  final UserDataShort user;
  final Function() onAccept;

  const UserRowCard(
    this.user,
    this.possibleRoles,
    this.onAccept, {
    super.key,
    this.nullRole = const UserRole(id: ' ', name: '', normalizedName: ''),
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) => Container(
        height: 75,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide()),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 100 * 20,
                  child: Text(
                    user.userName,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.fade,
                  ),
                ),
                SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width / 100 * 20,
                  child: buildDropdown(
                    roleFromUser: user.roles,
                    userRoles: possibleRoles,
                    context: context,
                    ref: ref,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _deleteButton(context),
                _passwordResetButton(context, ref),
              ],
            ),
          ],
        ),
      );

  Widget buildDropdown({
    required List<UserRole> roleFromUser,
    required List<UserRole> userRoles,
    required BuildContext context,
    required WidgetRef ref,
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
          onChanged: (role) {
            ref
                .read(userAdministrationProvider.notifier)
                .updateUser(user.copyWith(roles: [role!]))
                .then((r) {
              // ignore: unused_result
              ref.refresh(userAdministrationProvider);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  showCloseIcon: true,
                  content: Text(r ? 'Erfolgreich angepasst' : 'Leider ist etwas schief gegagen'),
                ),
              );
              // Navigator.of(context).restorablePushReplacementNamed(AppRoutes.viewScreen);
            });
          },
          items: userRoles
              .map((value) => DropdownMenuItem(
                    value: value,
                    child: Text(value.name),
                  ))
              .toList(),
        ),
      );

  Widget _deleteButton(BuildContext context) => Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: Container(
          width: 80,
          decoration: BoxDecoration(
              border: Border.all(color: AppColor.kPrimaryButtonColor, width: 1.5),
              borderRadius: BorderRadius.circular(6)),
          child: SymmetricButton(
            onPressed: () {
              Utilitis.askPopUp(
                context,
                message: 'Sind sie sicher, dass sie diesen Mitarbeitenden löschen wollen?',
                onAccept: onAccept,
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
        width: MediaQuery.of(context).size.width >= 1100
            ? 250
            : MediaQuery.of(context).size.width / 10 * 2.2,
        child: SymmetricButton(
          borderRadius: BorderRadius.circular(6),
          onPressed: () {
            Utilitis.askPopUp(context,
                message: 'Soll das Passwort wirklich zurück gesetzt werden?',
                onAccept: () => ref
                        .read(userAdministrationProvider.notifier)
                        .resetPassword(user.userName)
                        .then((e) {
                      _showNewPasswordPopUp(context, e);
                    }),
                onReject: () => Navigator.of(context).pop());
            log('Password reset for ${user.userName}');
          },
          text: 'Passwort zurücksetzen',
          overflow: TextOverflow.clip,
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
          style: Theme.of(context).textTheme.labelMedium?.copyWith(color: AppColor.kWhite),
        ),
      );

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
}
