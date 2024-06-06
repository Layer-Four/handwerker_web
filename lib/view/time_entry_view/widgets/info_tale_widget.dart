import 'package:flutter/material.dart';
import '../../../../models/time_models/time_vm/time_vm.dart';

class InfoTableWidget extends StatelessWidget {
  final TimeVMAdapter entry;
  const InfoTableWidget({
    required this.entry,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Am ${entry.date.day}.${entry.date.month}.${entry.date.year}'),
            Text('von ${entry.startTime.hour}:${entry.startTime.minute}'),
            Text('bis ${entry.endTime.hour}:${entry.endTime.minute}'),
            Text('Dauer ${entry.duration} min'),
            Text('Beschreibung ${entry.description}'),
          ],
        ),
      );
}
