import 'package:flutter/material.dart';

import '../customer_project_view/custom_project.dart';

// ignore: must_be_immutable
class RoleRowCard extends StatefulWidget {
  final CustomeProject project;
  final bool isFirst;
  final bool isLast;
  bool isContainerOpen;

  RoleRowCard(
    this.project, {
    super.key,
    this.isFirst = false,
    this.isLast = false,
    this.isContainerOpen = false,
  });

  @override
  State<RoleRowCard> createState() => _RoleRowCardState();
}

class _RoleRowCardState extends State<RoleRowCard> {
  List<String> roles = ['Admin', 'User', 'Guest']; // Example roles
  String? currentRole = 'User'; // Default or fetched role

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border(
            top: widget.isFirst ? BorderSide.none : const BorderSide(),
            bottom: widget.isLast ? const BorderSide() : BorderSide.none,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Name and role dropdown
              Expanded(
                child: Row(
                  children: [
                    Text(
                      widget.project.customer,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 20),
                    Container(
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
                    ),
                  ],
                ),
              ),

              // Reset password button
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // Implement password reset functionality
                    print('Password reset for ${widget.project.customer}');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Passwort zurücksetzen', style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      );
}
