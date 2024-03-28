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
      60000,
      11,
      1009,
      1009,
    ),
    const CustomeProject(
      'Berlin AG',
      'Tisch gebaut',
      20000,
      11,
      2099,
      9000,
    ),
    const CustomeProject(
      'Creative GmbH',
      'Fenster eingesetzt',
      20000,
      11,
      2,
      900000,
    ),
    const CustomeProject(
      'Fio Bestmann',
      'Steinloch 43\n22880, Hamburg',
      20000,
      2,
      2,
      1009,
    ),
    const CustomeProject(
      'Florian hensel',
      'große Straße 54\n22449, Kassel',
      20.000,
      2,
      2,
      122000,
    ),
  ];

  MyApp({super.key});

  //  const Text('Berichte', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(75, 30, 30, 30),
          child: Column(
            children: [
              Row(
                children: [
                  const Text('Berichte',
                      style: TextStyle(color: Colors.orange, fontSize: 20, fontWeight: FontWeight.bold)),
                  Container(
                    width: 800,
                    child: const Padding(
                      padding: EdgeInsets.only(
                        left: 80,
                      ),
                      child: Material(
                        elevation: 5,
                        //  borderRadius: BorderRadius.circular(16),
                        child: TextField(
                          decoration: InputDecoration(
                            isDense: true,
                            border: OutlineInputBorder(
                              //      borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(width: 1.0, color: Colors.grey),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blueGrey),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.redAccent),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.orangeAccent),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            contentPadding: EdgeInsets.all(8.0),
                            hintText: 'Suche...',
                            suffixIcon: Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                            suffixStyle: TextStyle(color: Colors.green),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
                    // Text('Beschreibung', style: TextStyle(color: Colors.grey)),
                    // Text('Anzahl Projekte', style: TextStyle(color: Colors.grey)),
                    // Text('Gesamtzeit', style: TextStyle(color: Colors.grey)),
                    // Text('Materialkosten', style: TextStyle(color: Colors.grey)),
                    Text('Umsatz', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(
                      width: 245,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              SizedBox(
                width: screenWidth > 600 ? double.infinity : null,
                height: 700,
                child: ListView.builder(
                  itemCount: project.length,
                  itemBuilder: (_, index) => CharacterCard(
                    project[index],
                    isFirst: index == 0,
                    isLast: index == project.length - 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
