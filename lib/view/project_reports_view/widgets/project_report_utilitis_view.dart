import 'package:flutter/material.dart';
import '../../../models/consumable_models/project_consumable_model/project_consumable.dart';
import '../../../models/service_models/service_project/service_project.dart';

class ProjectUtilitisView extends StatelessWidget {
  final Object utilits;
  const ProjectUtilitisView(this.utilits, {super.key});

  @override
  Widget build(BuildContext context) {
    ServiceProject? service;
    ProjectConsumable? consumable;
    if (utilits.toString().contains('service')) {
      service = utilits as ServiceProject;
    } else {
      consumable = utilits as ProjectConsumable;
    }

    assert((service == null && consumable != null) || (service != null && consumable == null));
    return SizedBox(
      height: 40,
      width: MediaQuery.of(context).size.width * 0.6,
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.2,
            child: Row(
              children: [
                Icon(service == null ? Icons.construction : Icons.person),
                Text(service != null ? service.serviceName : consumable!.consumableName),
                // overflow: TextOverflow.ellipsis,
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.2,
            child: Text(
              (service == null ? consumable!.consumableAmount : service.serviceAmount).toString(),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.2,
            child: Text(
              '${(service == null ? consumable!.consumablePrice : service.servicePrice).toStringAsFixed(2)}€ (${calculateRevenue().toStringAsFixed(2)}€)',
              overflow: TextOverflow.clip,
            ),
          ),
        ],
      ),
    );
  }

  double calculateRevenue() {
    if (utilits.toString().contains('service')) {
      final unit = utilits as ServiceProject;
      return unit.servicePrice * unit.serviceAmount;
    }
    final unit = utilits as ProjectConsumable;
    return unit.consumablePrice * unit.consumableAmount;
  }
}
