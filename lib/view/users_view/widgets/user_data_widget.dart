import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../constants/themes/app_color.dart';
import '../../../constants/utilitis/utilitis.dart';
import '../../../models/users_models/user_data_short/user_short.dart';
import '../../../models/users_models/user_role/user_role.dart';
import '../../../provider/user_provider/user_administration/user_administration._provider.dart';
import '../../shared_widgets/symetric_button_widget.dart';

class UserDataWidget extends ConsumerWidget {
  final List<UserRole> possibleRoles;
  final UserDataShort user;

  const UserDataWidget(
    this.user,
    this.possibleRoles, {
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4.0),
        child: Material(
          elevation: 3,
          child: SizedBox(
            height: 69,
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width > 1200
                            ? 300
                            : MediaQuery.of(context).size.width * 0.20,
                        child: Text(
                          user.userName,
                          style: Theme.of(context).textTheme.titleMedium,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        width: MediaQuery.of(context).size.width > 950
                            ? 150
                            : MediaQuery.of(context).size.width * 0.20,
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
                      _deleteUserButton(context, ref),
                      _passwordResetButton(context, ref),
                    ],
                  ),
                ],
              ),
            ),
          ),
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
          borderRadius: BorderRadius.circular(6),
          color: Colors.grey[100],
        ),
        child: DropdownButton(
          underline: const SizedBox.shrink(),
          isExpanded: true,
          value: roleFromUser.isEmpty ? null : roleFromUser.first,
          items: userRoles
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e.name),
                  ))
              .toList(),
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
                  content: Center(
                      child: Text(r ? 'Erfolgreich angepasst' : 'Leider ist etwas schief gegagen')),
                ),
              );
            });
          },
        ),
      );

  Widget _deleteUserButton(BuildContext context, WidgetRef ref) => Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: SizedBox(
          width: 80,
          child: SymmetricButton(
            onPressed: () {
              Utilitis.askPopUp(
                context,
                message: 'Sind sie sicher, dass sie diesen Mitarbeitenden löschen wollen?',
                onReject: () => Navigator.of(context).pop(),
                onAccept: () =>
                    ref.read(userAdministrationProvider.notifier).deleteUser(user.id).then((e) {
                  Navigator.of(context).pop();
                  Utilitis.showSnackBar(
                    context,
                    e
                        ? 'Mitarbeitenden erfolgreich gelöscht'
                        : 'Mitarbeitenden konnte nicht gelöscht werden',
                  );
                }),
              );
            },
            color: AppColor.kWhite,
            text: 'Löschen',
            overflow: TextOverflow.clip,
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
            textStyle: Theme.of(context)
                .textTheme
                .labelMedium
                ?.copyWith(color: AppColor.kPrimaryButtonColor),
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
                      Navigator.of(context).pop();
                      if (e.containsKey('Error')) {
                        return Utilitis.showSnackBar(context, 'Anfrage wurde abgewiesen');
                      }
                      Utilitis.showNewPasswordPopUp(context, e);
                    }),
                onReject: () => Navigator.of(context).pop());
          },
          text: 'Passwort zurücksetzen',
          overflow: TextOverflow.clip,
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
          textStyle: Theme.of(context).textTheme.labelMedium?.copyWith(color: AppColor.kWhite),
        ),
      );
}
