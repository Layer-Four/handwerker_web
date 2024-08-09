import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../models/time_models/time_vm/time_vm.dart';

class InvoiceTimeWidget extends StatelessWidget {
  final List<TimeVMAdapter> times;
  const InvoiceTimeWidget({
    super.key,
    required this.times,
  });
  @override
  Widget build(BuildContext context) => SizedBox(
      height: 175,
      child: times.isEmpty
          ? const Center(child: Text('Keine Zeiten eingetragen'))
          : Column(
              // TODO: think about a header row for descript data
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Zeiten'),
                SizedBox(
                  height: 150,
                  child: ListView.builder(
                    itemCount: times.length,
                    itemBuilder: (_, i) => Row(
                      children: [
                        const SizedBox(width: 30),
                        SizedBox(
                          width: 80,
                          child: Text(
                            DateFormat('d.M.y').format(times[i].date),
                            style: Theme.of(context).textTheme.labelLarge,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: Text(
                            'Tätigkeiten: ${times[i].service?.name ?? 'Kein Service'}',
                            style: Theme.of(context).textTheme.labelLarge,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.15,
                          child: Text(
                              '${DateFormat.Hm().format(times[i].startTime)} - ${DateFormat.Hm().format(times[i].endTime)} Uhr'),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.10,
                          child: Text('${times[i].getDurationInHours()} Std'),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.15,
                          child: Text(
                              '${((times[i].duration! ~/ 60) * (times[i].service!.hourlyRate ?? 0.0)).toStringAsFixed(2)}€'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ));
}
