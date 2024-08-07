import 'package:flutter/material.dart';

import '../../../../models/consumable_models/project_consumable_model/project_consumable.dart';

class InvoiceConsumableWidget extends StatelessWidget {
  final List<ProjectConsumable> consumables;
  const InvoiceConsumableWidget({super.key, required this.consumables});
  @override
  Widget build(BuildContext context) => SizedBox(
      child: consumables.isEmpty
          ? const Center(
              child: Text('Keine Materialien verwendet'),
            )
          : Column(children: [
              ...consumables.map(
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
                              'Material',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          Text(
                            e.consumableName,
                            style: Theme.of(context).textTheme.labelLarge,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Text(
                        'Menge: ${e.consumableAmount}',
                        style: Theme.of(context).textTheme.labelLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Text(
                        '${(e.consumableAmount * e.consumableNetPrice).toStringAsFixed(2)}€'),
                  ],
                ),
              )
            ]));
}

// ListView.builder(
//     itemCount: project.reportsList.length,
//     itemBuilder: (context, i) =>
//     ),

