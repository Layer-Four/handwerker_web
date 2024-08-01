import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../models/time_models/time_vm/time_vm.dart';

class InvoiceTimeWidget extends StatelessWidget {
  final List<TimeVMAdapter> times;
  const InvoiceTimeWidget({super.key, required this.times});
  @override
  Widget build(BuildContext context) => SizedBox(
        child: times.isEmpty
            ? const Center(child: Text('Keine Zeiten eingetragen'))
            : Column(
                children: [
                  ...times.map(
                    (e) => Row(
                      children: [
                        SizedBox(
                          width: 150,
                          // width: MediaQuery.of(context).size.width * 0.3,
                          child: Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Zeiten',
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                              ),
                              Text(
                                DateFormat('d.M.y').format(e.date),
                                style: Theme.of(context).textTheme.labelLarge,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Text(
                            'Tätigkeiten: ${e.service?.name ?? 'Kein Service'}',
                            style: Theme.of(context).textTheme.labelLarge,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Text(
                            '${DateFormat.Hm().format(e.startTime)} - ${DateFormat.Hm().format(e.endTime)} Uhr'),
                        Text('${e.getDurationInHours()} Stunden'),
                        Text(
                            '${((e.duration! ~/ 60) * (e.service!.hourlyRate ?? 0.0)).toStringAsFixed(2)}€'),
                      ],
                    ),
                  )
                ],
              ),
      );
}
