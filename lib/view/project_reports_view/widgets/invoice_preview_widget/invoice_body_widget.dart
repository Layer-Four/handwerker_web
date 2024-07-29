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

  Future<Uint8List> getBytes() async =>
      (await rootBundle.load('assets/images/img_techtool.png')).buffer.asUint8List();
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
                        child: const Text('Dokumentation'),
                      ),
                      Text(DateFormat('d.M.y').format(docu.startTimeDate!)),
                    ],
                  )),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.45,
                child: Text(
                  'Documentatio ${docu.workDescription}',
                  textAlign: TextAlign.center,
                  maxLines: null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.memory(
                  snapshot.requireData,
                  width: 60,
                  height: 30,
                ),
              ),
              Image.memory(
                snapshot.requireData,
                width: 80,
                height: 40,
              ),
            ],
          ));
}
