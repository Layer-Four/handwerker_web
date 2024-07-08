import 'package:flutter/material.dart';
import '../../../../models/time_models/time_vm/time_vm.dart';
import '../../../constants/utilitis/utilitis.dart';

class InfoTableWidget extends StatelessWidget {
  final TimeVMAdapter entry;
  const InfoTableWidget({
    required this.entry,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
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
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 120,
                      child: Text(
                        'Kunde:',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                    Text(
                        '${entry.customerName ?? 'Kein Kunde gefunden'} / ${entry.project?.title ?? 'Kein Projekt gefunden'}'),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
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
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: [
                    SizedBox(
                        width: 120,
                        child: Text(
                          'Von: ',
                          style: Theme.of(context).textTheme.labelLarge,
                        )),
                    Text(
                        ' ${entry.startTime.hour < 10 ? '0${entry.startTime.hour}' : entry.startTime.hour}:${entry.startTime.minute < 10 ? '0${entry.startTime.minute}' : entry.startTime.minute} Uhr'),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: [
                    SizedBox(
                        width: 120,
                        child: Text(
                          'Bis: ',
                          style: Theme.of(context).textTheme.labelLarge,
                        )),
                    Text(
                        ' ${entry.endTime.hour < 10 ? '0${entry.endTime.hour}' : entry.endTime.hour}:${entry.endTime.minute < 10 ? '0${entry.endTime.minute}' : entry.endTime.minute} Uhr'),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: [
                    SizedBox(
                        width: 120,
                        child: Text(
                          'Dauer: ',
                          style: Theme.of(context).textTheme.labelLarge,
                        )),
                    Text(Utilitis.buildDurationInHourers(entry.duration)),
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 120,
                    child: Text(
                      'Beschreibung: ',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width > 900
                        ? 500
                        : MediaQuery.of(context).size.width * 0.50,
                    child: Text(
                      entry.description ?? '',
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
