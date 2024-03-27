import 'package:flutter/material.dart';
import 'package:handwerker_web/view/customer_project_view/character_card.dart';
import 'package:handwerker_web/view/customer_project_view/custom_project.dart';

void docScreen() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<CustomeProject> project = [
    const CustomeProject(
      'Layer Four GmbH',
      'Austausch der\nHeizungsanlage',
      2,
      11,
      1009,
      1009,
    ),
    const CustomeProject(
      'Berlin AG',
      'Tisch gebaut',
      2,
      11,
      2099,
      9000,
    ),
    const CustomeProject(
      'Creative GmbH',
      'Fenster eingesetzt',
      1009,
      11,
      2,
      900000,
    ),
    const CustomeProject(
      'Fio Bestmann',
      'Steinloch 43\n22880, Hamburg',
      1009,
      2,
      2,
      1009,
    ),
    const CustomeProject(
      'Florian hensel',
      'große Straße 54\n22449, Kassel',
      1999,
      2,
      2,
      122000,
    ),
  ];

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Scaffold(
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(28),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 120, top: 20, right: 200),
                child: TextField(
                  decoration: InputDecoration(
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide:
                          const BorderSide(width: 1.0, color: Colors.grey),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey),
                    ),
                    errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.redAccent),
                    ),
                    focusedErrorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orangeAccent),
                    ),
                    disabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    contentPadding: const EdgeInsets.all(8.0),
                    hintText: 'Suche',
                    suffixIcon: const Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    suffixStyle: const TextStyle(color: Colors.green),
                  ),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Kunde',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text('Beschreibung', style: TextStyle(color: Colors.grey)),
                  Text('Anzahl Projekte', style: TextStyle(color: Colors.grey)),
                  Text('Gesamtzeit', style: TextStyle(color: Colors.grey)),
                  Text('Materialkosten', style: TextStyle(color: Colors.grey)),
                  Text('Umsatz', style: TextStyle(color: Colors.grey))
                ],
              ),
              SizedBox(
                width: screenWidth > 600 ? double.infinity : null,
                height: 700,
                child: ListView.builder(
                  itemCount: project.length,
                  itemBuilder: (_, index) {
                    return CharacterCard(
                      project[index],
                      isLast: index == project.length - 1,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
