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
    if (utilits.runtimeType == ServiceProject) {
      service = utilits as ServiceProject;
    } else {
      consumable = utilits as ProjectConsumable;
    }
    assert(service == null && consumable != null || service != null && consumable == null);
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Row(
            children: [
              Icon(service == null ? Icons.construction : Icons.person),
              const SizedBox(
                width: 2,
              ),
              Text(
                service == null ? consumable!.consumableName : service.serviceName,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
        Expanded(
            flex: 2,
            child: Text(
              (service == null ? consumable!.consumableAmount : service.serviceAmount).toString(),
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 16),
            )),
        Expanded(
          flex: 2,
          child: Text(
            '${(service == null ? consumable!.consumablePrice : service.servicePrice).toStringAsFixed(2)}€',
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            '${calculateRevenue(utilits).toStringAsFixed(2)}€',
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }

  double calculateRevenue(Object unit) {
    if (unit.runtimeType == ServiceProject) {
      unit as ServiceProject;
      return unit.servicePrice * unit.serviceAmount;
    }
    unit as ProjectConsumable;
    return unit.consumablePrice * unit.consumableAmount;
  }
}
