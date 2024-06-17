import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/project_models/customer_projekt_model/custom_project.dart';
import '../../../provider/customer_provider/customer_provider.dart';
import '../../shared_widgets/search_line_header.dart';
import '../../users_view/widgets/add_button_widget.dart';
import 'widgets/customer_card.dart';
import 'widgets/edit_customer.dart';

class CustomerBody extends ConsumerStatefulWidget {
  const CustomerBody({super.key});

  @override
  ConsumerState<CustomerBody> createState() => _CustomerBodyState();
}

class _CustomerBodyState extends ConsumerState<CustomerBody> {
  bool isAddConsumableOpen = false;
  int editingProjectIndex = -1;

  @override
  Widget build(BuildContext context) {
    final allCustomer = ref.watch(customerProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SearchLineHeader(title: 'Kundenverwaltung'),
              const SizedBox(
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Name',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: screenWidth > 600 ? double.infinity : null,
                height: MediaQuery.of(context).size.height / 2 - 100,
                child: ListView.builder(
                  itemCount: project.length,
                  itemBuilder: (_, index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        isAddConsumableOpen = !isAddConsumableOpen;
                        editingProjectIndex = index;
                      });
                    },
                    child: CustomerCard(project[index]),
                  ),
                ),
              ),
              AddButton(
                isOpen: isAddConsumableOpen,
                onTap: () {
                  log(isAddConsumableOpen.toString());
                  setState(() => isAddConsumableOpen = !isAddConsumableOpen);
                  log(isAddConsumableOpen.toString());
                },
                hideAbleChild: AddNewConsumable(
                  onSave: () {},
                  onCancel: () {
                    setState(() => isAddConsumableOpen = !isAddConsumableOpen);
                  },
                  project: editingProjectIndex != -1 ? project[editingProjectIndex] : null,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

final List<CustomeProject> project = [
  const CustomeProject(
    'Hans Müller',
    'Kontaktperson: Hans Müller\nEmail: hans.mueller@example.com\nTelefon: +49 030 1234567\nAdresse: Hauptstraße 10, 10115 Berlin\nKundennummer: K1001',
    false,
    0,
    11,
    '01.01.2024 - 01.06.2025',
    1009,
    1009,
  ),
  const CustomeProject(
    'Julia Schmidt',
    'Kontaktperson: Julia Schmidt\nEmail: julia.schmidt@example.com\nTelefon: +49 040 2345678\nAdresse: Gartenweg 5, 20095 Hamburg\nKundennummer: K1002',
    true,
    0,
    12,
    '01.01.2024 - 01.06.2025',
    2099,
    9000,
  ),
  const CustomeProject(
    'Michael Meier',
    'Kontaktperson: Michael Meier\nEmail: michael.meier@example.com\nTelefon: +49 0211 3456789\nAdresse: Am Markt 3, 40213 Düsseldorf\nKundennummer: K1003',
    true,
    0,
    13,
    '01.01.2024 - 01.06.2025',
    2,
    900000,
  ),
  const CustomeProject(
    'Claudia Weber',
    'Kontaktperson: Claudia Weber\nEmail: claudia.weber@example.com\nTelefon: +49 089 4567890\nAdresse: Schlossallee 12, 80333 München\nKundennummer: K1004',
    false,
    0,
    14,
    '01.01.2024 - 01.06.2025',
    3,
    1009,
  ),
  const CustomeProject(
    'Leibniz Gymnasium',
    'Kontaktperson: Dr. Stefan König\nEmail: info@leibniz-gymnasium.de\nTelefon: +49 0341 5678901\nAdresse: Schulstraße 4, 04109 Leipzig\nKundennummer: K1005',
    false,
    0,
    15,
    '01.01.2024 - 01.06.2025',
    4,
    122000,
  ),
  const CustomeProject(
    'Andrea Bauer',
    'Kontaktperson: Andrea Bauer\nEmail: andrea.bauer@example.com\nTelefon: +49 069 6789012\nAdresse: Zeil 29, 60313 Frankfurt\nKundennummer: K1006',
    false,
    0,
    16,
    '01.01.2024 - 01.06.2025',
    5,
    122000,
  ),
  const CustomeProject(
    'Thomas Grünwald',
    'Kontaktperson: Thomas Grünwald\nEmail: thomas.gruenwald@example.com\nTelefon: +49 0711 7890123\nAdresse: Königstraße 1, 70173 Stuttgart\nKundennummer: K1007',
    false,
    0,
    17,
    '01.01.2024 - 01.06.2025',
    6,
    122000,
  ),
  const CustomeProject(
    'Sophia Richter',
    'Kontaktperson: Sophia Richter\nEmail: sophia.richter@example.com\nTelefon: +49 0221 8901234\nAdresse: Domstraße 2, 50668 Köln\nKundennummer: K1008',
    false,
    0,
    18,
    '01.01.2024 - 01.06.2025',
    7,
    122000,
  ),
];
