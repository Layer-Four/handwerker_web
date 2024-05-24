import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/themes/app_color.dart';
import '../../../models/users_models/user_role/user_role.dart';
import '../../../provider/user_provider/user_provider.dart';
import '../../shared_view_widgets/symetric_button_widget.dart';
import '../user_view.dart';

class UserRowCard extends ConsumerStatefulWidget {
  final BoxConstraints constraints;
  final UserEntry user;
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
  // UserRole? _selectedRole;
  final List<UserRole> _possibleRoles = [];
  void initUserRoles() {
    ref.read(userProvider.notifier).loadUserRoles().then((e) => setState(() {
          _possibleRoles.addAll(e);
          // _selectedRole = _roles.first;
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
                width: currentSize.maxWidth / 10 * 3,
                child: Text(
                  widget.user.name,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 40,
                width: currentSize.maxWidth / 10 * 3,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width > 1000
                      ? 200
                      : currentSize.maxWidth / 10 * 3,
                  child: buildDropdown(
                      userRoles: widget.user.role,
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
                ref.read(userProvider.notifier).resetPassword(widget.user.name).then((e) {
                  showDialog(
                      context: context,
                      builder: (context) => Dialog(
                            child: Center(
                              child: Text(e.toString()),
                            ),
                          ));
                });
                log('Password reset for ${widget.user.name}');
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
    required List<UserRole> userRoles,
    required ValueChanged onChanged,
    required BuildContext context,
  }) =>
      Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: DropdownButtonFormField(
          isExpanded: true,
          value: userRoles.first,
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
                    enabled: false,
                    value: value,
                    child: Text(value.name),
                  ))
              .toList(),
        ),
      );
}
