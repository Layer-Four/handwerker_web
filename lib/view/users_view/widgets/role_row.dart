import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/users_models/user_role/user_role.dart';
import '../../../provider/user_provider/user_provider.dart';
import '../../customer_project_view/custom_project.dart';
import '../../shared_view_widgets/symetric_button_widget.dart';

class UserRowCard extends ConsumerStatefulWidget {
  final BoxConstraints constraints;
  final CustomeProject project;
  final bool isFirst;
  final bool isLast;

  const UserRowCard(
    this.constraints,
    this.project, {
    super.key,
    this.isFirst = false,
    this.isLast = false,
  });

  @override
  ConsumerState<UserRowCard> createState() => _RoleRowCardState();
}

class _RoleRowCardState extends ConsumerState<UserRowCard> {
  //List<String> roles = ['Admin', 'User', 'Guest']; // Example roles
  //String? currentRole = 'User'; // Default or fetched role

  UserRole? _selectedRole;
  final List<UserRole> _roles = [];
  void initUserRoles() {
    ref.read(userProvider.notifier).loadUserRoles().then((e) => setState(() {
          _roles.addAll(e);
          _selectedRole = _roles.first;
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
              Container(
                width: currentSize.maxWidth / 10 * 3,
                child: Text(
                  widget.project.customer,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              // const SizedBox(width: 20),
              /*                    Container(
                  width: 300,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.grey[100],
                  ),
                  child: DropdownButton<String>(
                    value: currentRole,
                    icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
                    elevation: 16,
                    dropdownColor: Colors.grey[300],
                    style: TextStyle(color: Colors.black),
                    underline: Container(height: 0),
                    onChanged: (String? newValue) {
                      setState(() {
                        currentRole = newValue!;
                      });
                    },
                    items: ['Admin', 'User', 'Guest']
                        .map<DropdownMenuItem<String>>((String value) => DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            ))
                        .toList(),
                  ),
                ),*/
              // buildDropdown(
              //   options: ['Admin', 'Mitarbeiter'],
              //   // selectedValue: roleOption,
              //   onChanged: (value) {
              //     setState(() {
              //       roleOption = value;
              //     });
              //   },
              //   context: context,
              // ),
              SizedBox(
                width: currentSize.maxWidth / 10 * 3,
                child: buildDropdown(
                    options: _roles,
                    onChanged: (value) {
                      setState(() {
                        _selectedRole = value;
                      });
                    },
                    context: context),
                // child: buildDropdown(options: _roles),
              ),
            ],
          ),
          SizedBox(
            width:
                MediaQuery.of(context).size.width >= 1100 ? 300 : currentSize.maxWidth / 10 * 2.5,
            child: SymmetricButton(
              onPressed: () {
                log('Password reset for ${widget.project.customer}');
              },
              text: 'Passwort zurücksetzen',
              overflow: TextOverflow.clip,
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              // style: const TextStyle(color: Colors.white, fontSize: 1),
              // style: ElevatedButton.styleFrom(
              //   backgroundColor: Colors.orange,
              //   padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(8),
              //   ),
              // ),
              // child: const Text('Passwort zurücksetzen',
              //     style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  // Widget buildDropdown({
  //   required List<UserRole> options,
  //   Function(UserRole?)? onChanged,
  // }) =>
  //     DropdownButtonFormField(
  //       isExpanded: true,
  //       value: options.first,
  //       decoration: InputDecoration(
  //         hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
  //               color: const Color.fromARGB(255, 220, 217, 217),
  //             ),
  //         contentPadding: const EdgeInsets.symmetric(
  //           horizontal: 15,
  //           vertical: 5,
  //         ),
  //         enabledBorder: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(12),
  //           borderSide: const BorderSide(
  //             color: Color.fromARGB(255, 220, 217, 217),
  //           ),
  //         ),
  //         focusedBorder: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(12),
  //           borderSide: const BorderSide(color: Color.fromARGB(255, 220, 217, 217)),
  //         ),
  //         filled: true,
  //         fillColor: Colors.grey[100],
  //       ),
  //       onChanged: onChanged,
  //       items: options
  //           .map((value) => DropdownMenuItem(
  //                 value: value,
  //                 child: Text(value.name),
  //               ))
  //           .toList(),
  //     );
  Widget buildDropdown({
    required List<UserRole> options,
    required ValueChanged onChanged,
    required BuildContext context,
  }) =>
      Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: DropdownButtonFormField(
          isExpanded: true,
          value: _selectedRole,
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
          items: options
              .map<DropdownMenuItem>((value) => DropdownMenuItem(
                    value: value,
                    child: Text(value.name),
                  ))
              .toList(),
        ),
      );
}
