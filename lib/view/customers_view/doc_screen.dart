import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../customer_project_view/custom_project.dart';
import '../shared_view_widgets/search_line_header.dart';
import 'customer_card.dart';
import 'edit_customer.dart';

class CustomerBody extends ConsumerStatefulWidget {
  //StatelessWidget
  const CustomerBody({super.key});

  @override
  _CustomerBodyState createState() => _CustomerBodyState();
}

class _CustomerBodyState extends ConsumerState<CustomerBody> {
  //Call fetch infos here

  //  const Text('Berichte', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
  bool isAddConsumableOpen = false;
  int editingProjectIndex = -1;

  @override
  Widget build(BuildContext context) {
    //, WidgetRef ref
    final screenWidth = MediaQuery.of(context).size.width;
    //ref.read(customerProjectProvider.notifier).fetchInfos(); //todo: implement api

/*    late List<TextEditingController> _controllers;
    late List<bool> _isEditing;

    void _addNewConsumable() {
      setState(() {
        final newController = TextEditingController();
        _controllers.add(newController);
        _isEditing.add(true);
      });
    }*/

    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(75, 30, 65, 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SearchLineHeader(title: 'Kundenverwaltung'),
              const SizedBox(
                height: 60,
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Name',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                /*isAddConsumableOpen
                    ? MediaQuery.of(context).size.height / 3
                    : MediaQuery.of(context).size.height - 300,*/
                child: ListView.builder(
                  itemCount: project.length,
                  itemBuilder: (_, index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        isAddConsumableOpen = !isAddConsumableOpen;
                        editingProjectIndex = index;
                      });
                    },
                    child: CustomerCard(
                      project[index],
                      isFirst: index == 0,
                      isLast: index == project.length,
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: SizedBox(
                    height: 30,
                    width: 30,
                    child: Material(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(50),
                      child: Center(
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: Icon(
                            isAddConsumableOpen ? Icons.remove : Icons.add,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              isAddConsumableOpen = !isAddConsumableOpen;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: isAddConsumableOpen,
                child: SizedBox(
                  // alignment: Alignment.topLeft,
                  height: MediaQuery.of(context).size.height / 3,
                  width: screenWidth / 2,
                  child: AddNewConsumable(
                    onSave: () {
                      print('save');
                      //Todo: Call api for saving
                      //If Edit was clicked (therefore index != -1), also pass which customer is to be edited
                      //Might be a different apie then
                      /*                  setState(() {
                        _addNewConsumable();
                      });*/
                    },
                    onCancel: () {
                      print('cancel');
                      setState(() {
                        isAddConsumableOpen = !isAddConsumableOpen;
                      });
                    },
                    project: editingProjectIndex != -1
                        ? project[editingProjectIndex]
                        : null, //If a project was clicked instead of the + icon, we pass the project and prefill the data
                  ),
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
    // Using customer name as the customer field
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

/*

final List<CustomeProject> project = [
  const CustomeProject(
    'Kunde X',
    'Austausch der\nHeizungsanlage',
    false,
    60000,
    11,
    '01.01.2024 - 01.06.2025',
    1009,
    1009,
  ),
  const CustomeProject(
    'Kunde Y',
    'Tisch gebaut',
    true,
    20000,
    11,
    '01.01.2024 - 01.06.2025',
    2099,
    9000,
  ),
  const CustomeProject(
    'Kunde XY',
    'Fenster eingesetzt',
    true,
    20000,
    11,
    '01.01.2024 - 01.06.2025',
    2,
    900000,
  ),
  const CustomeProject(
    'Fio Bestmann',
    'Steinloch 43\n22880, Hamburg',
    true,
    20000,
    2,
    '01.01.2024 - 01.06.2025',
    2,
    1009,
  ),
  const CustomeProject(
    'Florian hensel',
    'große Straße 54\n22449, Kassel',
    true,
    20.000,
    2,
    '01.01.2024 - 01.06.2025',
    2,
    122000,
  ),
];
*/
