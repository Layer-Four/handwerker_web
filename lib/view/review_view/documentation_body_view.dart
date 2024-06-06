import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/project_models/customer_projekt_model/custom_project.dart';
import '../shared_widgets/character_card.dart';
import '../shared_widgets/search_line_header.dart';

class CustomerProjectMain extends ConsumerWidget {
  const CustomerProjectMain({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(75, 30, 30, 15),
        child: Column(
          children: [
            const SearchLineHeader(title: 'Berichte'),
            const SizedBox(
              height: 60,
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Text(
                    'Kunde',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Text('Umsatz', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(
                    width: 140,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            SizedBox(
              width: screenWidth > 600 ? double.infinity : null,
              height: MediaQuery.of(context).size.height - 300,
              child: ListView.builder(
                itemCount: project.length,
                itemBuilder: (_, index) => CharacterCard(
                  project[index],
                  isFirst: index == 0,
                  isLast: index == project.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final List<CustomeProject> project = [
  const CustomeProject(
    'Reparatur Schaltung',
    '',
    false,
    50,
    0,
    '02.05.2024 - 03.05.2024',
    0,
    0,
  ),
  const CustomeProject(
    'Installation Beleuchtung',
    '',
    true,
    60,
    0,
    '10.05.2024 - 12.05.2024',
    0,
    0,
  ),
  const CustomeProject(
    'Reparatur Wasserleitung',
    '',
    true,
    70,
    0,
    '15.05.2024 - 17.05.2024',
    0,
    0,
  ),
  const CustomeProject(
    'Behebung Leckage',
    '',
    true,
    60,
    0,
    '20.05.2024 - 21.05.2024',
    0,
    0,
  ),
  const CustomeProject(
    'Anstrich Innenwand',
    '',
    true,
    70,
    0,
    '25.05.2024 - 26.05.2024',
    0,
    0,
  ),
  const CustomeProject(
    'Tapezierarbeiten',
    '',
    true,
    50,
    0,
    '30.05.2024 - 01.06.2024',
    0,
    0,
  ),
  const CustomeProject(
    'Küchen Einbau',
    '',
    true,
    70,
    0,
    '04.06.2024 - 06.06.2024',
    0,
    0,
  ),
  const CustomeProject(
    'Fensterherstellung',
    '',
    true,
    60,
    0,
    '10.06.2024 - 12.06.2024',
    0,
    0,
  ),
  const CustomeProject(
    'Dachisolierung',
    '',
    true,
    40,
    0,
    '15.06.2024 - 17.06.2024',
    0,
    0,
  ),
  const CustomeProject(
    'Badsanierung',
    '',
    true,
    50,
    0,
    '20.06.2024 - 22.06.2024',
    0,
    0,
  ),
];
