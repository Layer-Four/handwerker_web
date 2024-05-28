import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/themes/app_color.dart';
import '../../../models/users_models/user_data_short/user_short.dart';
import '../../../models/users_models/user_role/user_role.dart';
import '../../../provider/user_provider/user_provider.dart';
import '../../shared_view_widgets/symetric_button_widget.dart';

class UserRowCard extends ConsumerWidget {
  final BoxConstraints constraints;
  final List<UserRole> possibleRoles;
  final UserDataShort user;
  final bool isFirst;
  final bool isLast;

  const UserRowCard(
    this.constraints,
    this.possibleRoles,
    this.user, {
    super.key,
    this.isFirst = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context, ref) => Container(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: constraints.maxWidth / 100 * 30,
                  child: Text(
                    user.userName,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 40,
                  width: constraints.maxWidth / 100 * 25,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width > 1000
                        ? 200
                        : constraints.maxWidth / 100 * 30,
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
                ),
              ],
            ),
            SizedBox(
              width:
                  MediaQuery.of(context).size.width >= 1100 ? 300 : constraints.maxWidth / 10 * 2.8,
              child: SymmetricButton(
                onPressed: () {
                  ref.read(userProvider.notifier).resetPassword(user.userName).then((e) {
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
                  });
                  log('Password reset for ${user.userName}');
                },
                text: 'Passwort zurücksetzen',
                overflow: TextOverflow.clip,
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                style: TextStyle(
                  fontSize: 16,
                  color: AppColor.kWhite,
                ),
              ),
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
      Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: DropdownButtonFormField<UserRole>(
          isExpanded: true,
          value: userRoles.firstWhere((e) => e.name == roleFromUser.first.name),
          decoration: InputDecoration(
            //   hintText: 'Select option',
            //   hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
            //         color: const Color.fromARGB(255, 220, 217, 217),
            //       ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 5,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 220, 217, 217),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color.fromARGB(255, 220, 217, 217)),
            ),
            filled: true,
            fillColor: Colors.grey[100],
          ),
          onChanged: onChanged,
          items: userRoles
              .map((value) => DropdownMenuItem(
                    onTap: () {
                      // TODO: Update Function to provider Method and update Database
                      final x = user.copyWith(roles: [value]);
                      log(x.toJson().toString());
                    },
                    value: value,
                    child: Text(value.name),
                  ))
              .toList(),
        ),
      );
}
