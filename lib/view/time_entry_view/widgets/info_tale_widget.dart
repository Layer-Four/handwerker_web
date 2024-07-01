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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 120,
                  child: Text(
                    'Mitarbeitender: ',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
                Text(entry.user?.userName ?? 'Mitarbeitenden ist nicht mehr in der Datenbank'),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 120,
                  child: Text(
                    'Am:',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
                Text('${entry.date.day}.${entry.date.month}.${entry.date.year}'),
              ],
            ),
            Row(
              children: [
                SizedBox(
                    width: 120,
                    child: Text(
                      'Von: ',
                      style: Theme.of(context).textTheme.labelLarge,
                    )),
                Text(' ${entry.startTime.hour}:${entry.startTime.minute}'),
              ],
            ),
            Row(
              children: [
                SizedBox(
                    width: 120,
                    child: Text(
                      'Bis: ',
                      style: Theme.of(context).textTheme.labelLarge,
                    )),
                Text(' ${entry.endTime.hour}:${entry.endTime.minute}'),
              ],
            ),
            Row(
              children: [
                SizedBox(
                    width: 120,
                    child: Text(
                      'Dauer: ',
                      style: Theme.of(context).textTheme.labelLarge,
                    )),
                Text('${entry.duration} min'),
              ],
            ),
            Row(
              children: [
                Text(
                  'Beschreibung: ',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                SizedBox(
                  child: Text('${entry.description}'),
                ),
              ],
            ),
          ],
        ),
      );
}
