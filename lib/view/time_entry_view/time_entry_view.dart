import 'package:flutter/material.dart';

class TimeEntryBody extends StatelessWidget {
  const TimeEntryBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueAccent,
      width: double.infinity,
      height: double.infinity,
      child: Center(child: Text('Zeiteintrag')),
    );
  }
}
