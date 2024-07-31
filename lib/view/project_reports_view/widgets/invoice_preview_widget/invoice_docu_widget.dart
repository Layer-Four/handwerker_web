import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../../../models/time_models/project_time_model/project_time_entry.dart';

class InvoiceDokuWidgets extends StatelessWidget {
  final ProjectTimeEntry docu;
  const InvoiceDokuWidgets({
    super.key,
    required this.docu,
  });

  Future<List> getBytes() async {
    final list = [];
    list.add((await rootBundle.load('assets/images/construction1.png')).buffer.asUint8List());
    list.add((await rootBundle.load('assets/images/img_techtool.png')).buffer.asUint8List());
    return list;
  }

  @override
  Widget build(BuildContext context) => FutureBuilder(
      future: getBytes(),
      builder: (context, snapshot) => Row(
            children: [
              SizedBox(
                  width: 150,
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Dokumentation',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      Text(
                        DateFormat('d.M.y').format(docu.startTimeDate!),
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ],
                  )),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.45,
                child: Text(
                  'Documentation ${docu.workDescription}',
                  textAlign: TextAlign.center,
                  maxLines: null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.memory(
                  snapshot.requireData[0],
                  width: 60,
                  height: 30,
                ),
              ),
              Image.memory(
                snapshot.requireData[1],
                width: 80,
                height: 40,
              ),
            ],
          ));
}
