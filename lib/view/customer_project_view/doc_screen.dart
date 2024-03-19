import 'package:flutter/material.dart';
import 'package:handwerker_web/view/customer_project_view/character_card.dart';
import 'package:handwerker_web/view/customer_project_view/custom_project.dart';

void docScreen() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<CustomeProject> project = [
    CustomeProject(
      'Kunde',
      'Timo Meyer',
      'Leisten abringen und anderer Pfusch',
      DateTime(2024, 09, 23),
      50000,
    ),
    CustomeProject(
      'Kunde',
      'Timo Meyer',
      'Leisten abringen und anderer Pfusch',
      DateTime(2024, 09, 23),
      50000,
    ),
    CustomeProject(
      'Kunde',
      'Timo Meyer',
      'Leisten abringen und anderer Pfusch',
      DateTime(2024, 09, 23),
      50000,
    ),
    CustomeProject(
      'Kunde',
      'Timo Meyer',
      'Leisten abringen und anderer Pfusch',
      DateTime(2024, 09, 23),
      50000,
    ),
    CustomeProject(
      'Kunde',
      'Timo Meyer',
      'Leisten abringen und anderer Pfusch',
      DateTime(2024, 09, 23),
      50000,
    ),
    CustomeProject(
      'Kunde',
      'Timo Meyer',
      'Leisten abringen und anderer Pfusch',
      DateTime(2024, 09, 23),
      50000,
    ),
    CustomeProject(
      'Kunde',
      'Timo Meyer',
      'Leisten abringen und anderer Pfusch',
      DateTime(2024, 09, 23),
      50000,
    ),
    CustomeProject(
      'Kunde',
      'Timo Meyer',
      'Leisten abringen und anderer Pfusch',
      DateTime(2024, 09, 23),
      50000,
    ),
    CustomeProject(
      'Kunde',
      'Timo Meyer',
      'Leisten abringen und anderer Pfusch',
      DateTime(2024, 09, 23),
      50000,
    ),
    CustomeProject(
      'Kunde',
      'Timo Meyer',
      'Leisten abringen und anderer Pfusch',
      DateTime(2024, 09, 23),
      50000,
    ),
    CustomeProject(
      'Kunde',
      'Timo Meyer',
      'Leisten abringen und anderer Pfusch',
      DateTime(2024, 09, 23),
      50000,
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
                    'Kunde/Projekt',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text('Beschreibung', style: TextStyle(color: Colors.grey)),
                  Text('Letztes Datum', style: TextStyle(color: Colors.grey)),
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
