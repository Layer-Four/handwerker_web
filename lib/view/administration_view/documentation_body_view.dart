import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../shared_view_widgets/search_line_header.dart';
import 'widgets/character_card.dart';
import '../../models/project_models/customer_projekt_model/custom_project.dart';

class CustomerProjectMain extends ConsumerWidget {
  //StatelessWidget
  const CustomerProjectMain({super.key});

  //Call fetch infos here

  //  const Text('Berichte', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    //ref.read(customerProjectProvider.notifier).fetchInfos(); //todo: implement api

    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(75, 30, 30, 15),
        child: Column(
          children: [
            const SearchLineHeader(title: 'Berichte'),
/*            Row(
              children: [
                const Text('Berichte',
                    style: TextStyle(color: Colors.orange, fontSize: 20, fontWeight: FontWeight.bold)),
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
            ),*/
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

/*
final List<CustomeProject> project = [
  const CustomeProject(
    'Hans Müller',
    'Komplette Erneuerung der Elektrik in einem Altbau.',
    false,
    0,
    1,
    '01.05.2024 - 15.05.2024',
    0,
    0,
  ),
  const CustomeProject(
    'Julia Schmidt',
    'Installation neuer Sanitäranlagen in einer neu gebauten Villa.',
    true,
    0,
    2,
    '10.04.2024 - 30.04.2024',
    0,
    0,
  ),
  const CustomeProject(
    'Michael Meier',
    'Neuanstrich der Außenfassade eines Einfamilienhauses.',
    true,
    0,
    3,
    '20.04.2024 - 05.05.2024',
    0,
    0,
  ),
  const CustomeProject(
    'Claudia Weber',
    'Maßanfertigung und Installation einer neuen Küche.',
    false,
    0,
    4,
    '15.05.2024 - 30.05.2024',
    0,
    0,
  ),
  const CustomeProject(
    'Leibniz Gymnasium',
    'Reparatur und Isolierung des Schuldachs.',
    false,
    0,
    5,
    '01.06.2024 - 15.07.2024',
    0,
    0,
  ),
  const CustomeProject(
    'Andrea Bauer',
    'Komplettsanierung eines Badezimmers inklusive moderner Fliesen.',
    false,
    0,
    6,
    '05.06.2024 - 20.06.2024',
    0,
    0,
  ),
  const CustomeProject(
    'Thomas Grünwald',
    'Landschaftsgestaltung inklusive Teichanlage für einen Privatgarten.',
    true,
    0,
    7,
    '25.04.2024 - 10.05.2024',
    0,
    0,
  ),
  const CustomeProject(
    'Sophia Richter',
    'Hochwertige Fliesenverlegung in einem Luxus-Penthouse.',
    true,
    0,
    8,
    '03.04.2024 - 18.04.2024',
    0,
    0,
  ),
];*/
/*

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
];*/
