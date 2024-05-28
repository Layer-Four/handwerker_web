import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/themes/app_color.dart';
import '../../../models/users_models/user_data_short/user_short.dart';
import '../../../models/users_models/user_role/user_role.dart';
import '../../../provider/user_provider/user_provider.dart';
import '../../shared_view_widgets/symetric_button_widget.dart';

class UserRowCard extends ConsumerStatefulWidget {
  final BoxConstraints constraints;
  final UserDataShort user;
  final bool isFirst;
  final bool isLast;

  const UserRowCard(
    this.constraints,
    this.user, {
    super.key,
    this.isFirst = false,
    this.isLast = false,
  });

  @override
  ConsumerState<UserRowCard> createState() => _RoleRowCardState();
}

class _RoleRowCardState extends ConsumerState<UserRowCard> {
  final List<UserRole> _possibleRoles = [];
  void initUserRoles() {
    ref.read(userProvider.notifier).loadUserRoles().then((e) => setState(() {
          _possibleRoles.addAll(e);
        }));
  }

  String? roleOption;

  @override
  void initState() {
    super.initState();
    initUserRoles();
  }

  @override
  Widget build(BuildContext context) {
    final currentSize = widget.constraints;
    return Container(
      height: 75,
      width: currentSize.maxWidth,
      decoration: BoxDecoration(
        border: Border(
          top: widget.isFirst ? BorderSide.none : const BorderSide(),
          bottom: widget.isLast ? const BorderSide() : BorderSide.none,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: currentSize.maxWidth / 100 * 30,
                child: Text(
                  widget.user.userName,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 40,
                width: currentSize.maxWidth / 100 * 25,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width > 1000
                      ? 200
                      : currentSize.maxWidth / 100 * 30,
                  child: buildDropdown(
                      roleFromUser: widget.user.roles,
                      userRoles: _possibleRoles,
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
                MediaQuery.of(context).size.width >= 1100 ? 300 : currentSize.maxWidth / 10 * 2.8,
            child: SymmetricButton(
              onPressed: () {
                ref.read(userProvider.notifier).resetPassword(widget.user.userName).then((e) {
                  showDialog(
                      context: context,
                      builder: (context) => Dialog(
                            child: Center(
                              child: Text(e.toString()),
                            ),
                          ));
                });
                log('Password reset for ${widget.user.userName}');
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
  }

  Widget buildDropdown({
    required List<UserRole> roleFromUser,
    required List<UserRole> userRoles,
    required ValueChanged onChanged,
    required BuildContext context,
  }) =>
      Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: DropdownButtonFormField(
          isExpanded: true,
          value: userRoles.firstWhere((e) => e.name == roleFromUser.first.name),
          decoration: InputDecoration(
            hintText: 'Select option',
            hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: const Color.fromARGB(255, 220, 217, 217),
                ),
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
              .map<DropdownMenuItem>((value) => DropdownMenuItem(
                    onTap: () {
                      // TODO: Update Function to provider Method and update Database
                      final x = widget.user.copyWith(roles: [value]);
                      log(x.toJson().toString());
                    },
                    value: value,
                    child: Text(
                      value.name,
                      style: !roleFromUser.contains(value)
                          ? null
                          : TextStyle(color: AppColor.kPrimaryButtonColor),
                    ),
                  ))
              .toList(),
        ),
      );
}
