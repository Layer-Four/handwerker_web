import 'package:flutter/material.dart';

class UserBody extends StatelessWidget {
  const UserBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.cyan,
      width: double.infinity,
      height: double.infinity,
      child: Center(child: Text('Mitarbeiter')),
    );
  }
}
