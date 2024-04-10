import 'package:flutter/material.dart';
import 'character_card.dart';
import 'custom_project.dart';

class CustomerProjectMain extends StatelessWidget {
  const CustomerProjectMain({super.key});

  //  const Text('Berichte', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(75, 30, 30, 30),
        child: Column(
          children: [
            Row(
              children: [
                const Text('Berichte',
                    style:
                        TextStyle(color: Colors.orange, fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(
                  width: screenWidth / 2,
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
    'Layer Four GmbH',
    'Austausch der\nHeizungsanlage',
    false,
    60000,
    11,
    '01.01.2024 - 01.06.2025',
    1009,
    1009,
  ),
  const CustomeProject(
    'Berlin AG',
    'Tisch gebaut',
    true,
    20000,
    11,
    '01.01.2024 - 01.06.2025',
    2099,
    9000,
  ),
  const CustomeProject(
    'Creative GmbH',
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