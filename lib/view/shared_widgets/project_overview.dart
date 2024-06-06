import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../models/project_models/customer_projekt_model/custom_project.dart';
import 'project_card.dart';

// ignore: must_be_immutable
class ProjectOverview extends StatefulWidget {
  final CustomeProject project;

  const ProjectOverview({super.key, required this.project});

  @override
  State<ProjectOverview> createState() => _CharacterCardState();
}

class _CharacterCardState extends State<ProjectOverview> {
  final List<CustomeProject> project = [
    const CustomeProject(
      'Elektrische Erneuerung Müller',
      'Komplette Erneuerung der Elektrik in einem Altbau. Status: Geplant. 01.05.2024 - 15.05.2024',
      false,
      60000,
      11,
      '01.05.2024 - 15.05.2024',
      1009,
      1009,
      [
        ProjectReport(
          'Heizkörperinstallation',
          'Im Herzen Berlins steht ein historisches Gebäude, das dringend einer Sanierung bedarf. Unser Projektziel ist es, den Charme des alten Gebäudes zu bewahren, während wir moderne Technologien einsetzen, um Energieeffizienz und Wohnkomfort zu verbessern. Die Sanierungsarbeiten umfassen die Restaurierung der Fassade unter Denkmalschutzauflagen, die Erneuerung der Elektro- und Wasserinstallationen sowie die Dämmung der Außenwände und des Daches. Besondere Aufmerksamkeit wird der sorgfältigen Auswahl von Materialien gewidmet, die sowohl historisch authentisch als auch umweltfreundlich sind. Durch die Kombination traditioneller Handwerkstechniken mit modernster Technologie schaffen wir ein energieeffizientes Zuhause, das die Geschichte atmet. Das Projekt wird in enger Zusammenarbeit mit Denkmalschutzbehörden durchgeführt, um sicherzustellen, dass alle Renovierungsarbeiten den gesetzlichen Anforderungen entsprechen. Unsere Vision ist es, eine Brücke zwischen Vergangenheit und Zukunft zu schlagen und einen Wohnraum zu schaffen, der Generationen überdauert.',
          '08.04.2026',
          ['assets/images/construction1.png', 'assets/images/construction2.png'],
        ),
        ProjectReport(
          'Heizkörperinstallation 2',
          'Installation neuer Heizkörper im gesamten Gebäude',
          '08.04.2026',
          ['assets/images/construction1.png', 'assets/images/construction2.png'],
        ),
        ProjectReport(
          'Heizkörperinstallation3 ',
          'Installation neuer Heizkörper im gesamten Gebäude',
          '08.04.2026',
          ['assets/images/construction1.png', 'assets/images/construction2.png'],
        ),
      ],
    ),
    const CustomeProject(
      'Sanitärinstallation Villa Schmidt',
      'Installation neuer Sanitäranlagen in einer neu gebauten Villa. Status: In Arbeit. 10.04.2024 - 30.04.2024',
      true,
      20000,
      12,
      '10.04.2024 - 30.04.2024',
      2099,
      9000,
      [
        ProjectReport(
          'Tischlerei',
          'Herstellung eines maßgeschneiderten Tisches aus Eichenholz',
          '08.04.2026',
          ['assets/images/construction1.png', 'assets/images/construction2.png'],
        ),
      ],
    ),
    const CustomeProject(
      'Fassadenanstrich Meier',
      'Neuanstrich der Außenfassade eines Einfamilienhauses. Status: In Arbeit. 20.04.2024 - 05.05.2024',
      true,
      20000,
      13,
      '20.04.2024 - 05.05.2024',
      2,
      900000,
      [
        ProjectReport(
          'Fensterinstallation',
          'Einsetzen der Fenster in Neubau',
          '08.04.2026',
          ['assets/images/construction1.png', 'assets/images/construction2.png'],
        ),
      ],
    ),
    const CustomeProject(
      'Küchenmontage Weber',
      'Maßanfertigung und Installation einer neuen Küche. Status: Geplant. 15.05.2024 - 30.05.2024',
      false,
      20000,
      14,
      '15.05.2024 - 30.05.2024',
      3,
      1009,
      [
        ProjectReport(
          'Sanierung',
          'Sanierung des Steinlochs',
          '08.04.2026',
          ['assets/images/construction1.png', 'assets/images/construction2.png'],
        ),
      ],
    ),
    const CustomeProject(
      'Dachreparatur Leibniz Gymnasium',
      'Reparatur und Isolierung des Schuldachs. Status: Geplant. 01.06.2024 - 15.07.2024',
      false,
      20000,
      15,
      '01.06.2024 - 15.07.2024',
      4,
      122000,
      [
        ProjectReport(
          'Heizkörperinstallation',
          'Im Herzen Berlins steht ein historisches Gebäude, das dringend einer Sanierung bedarf. Unser Projektziel ist es, den Charme des alten Gebäudes zu bewahren, während wir moderne Technologien einsetzen, um Energieeffizienz und Wohnkomfort zu verbessern. Die Sanierungsarbeiten umfassen die Restaurierung der Fassade unter Denkmalschutzauflagen, die Erneuerung der Elektro- und Wasserinstallationen sowie die Dämmung der Außenwände und des Daches. Besondere Aufmerksamkeit wird der sorgfältigen Auswahl von Materialien gewidmet, die sowohl historisch authentisch als auch umweltfreundlich sind. Durch die Kombination traditioneller Handwerkstechniken mit modernster Technologie schaffen wir ein energieeffizientes Zuhause, das die Geschichte atmet. Das Projekt wird in enger Zusammenarbeit mit Denkmalschutzbehörden durchgeführt, um sicherzustellen, dass alle Renovierungsarbeiten den gesetzlichen Anforderungen entsprechen. Unsere Vision ist es, eine Brücke zwischen Vergangenheit und Zukunft zu schlagen und einen Wohnraum zu schaffen, der Generationen überdauert.',
          '08.04.2026',
          ['assets/images/construction1.png', 'assets/images/construction2.png'],
        ),
        ProjectReport(
          'Heizkörperinstallation 2',
          'Installation neuer Heizkörper im gesamten Gebäude',
          '08.04.2026',
          ['assets/images/construction1.png', 'assets/images/construction2.png'],
        ),
        ProjectReport(
          'Heizkörperinstallation3 ',
          'Installation neuer Heizkörper im gesamten Gebäude',
          '08.04.2026',
          ['assets/images/construction1.png', 'assets/images/construction2.png'],
        ),
      ],
    ),
    const CustomeProject(
      'Badezimmerrenovierung Bauer',
      'Komplettsanierung eines Badezimmers inklusive moderner Fliesen. Status: Geplant. 05.06.2024 - 20.06.2024',
      false,
      20000,
      16,
      '05.06.2024 - 20.06.2024',
      5,
      122000,
      [
        ProjectReport(
          'Heizkörperinstallation',
          'Im Herzen Berlins steht ein historisches Gebäude, das dringend einer Sanierung bedarf. Unser Projektziel ist es, den Charme des alten Gebäudes zu bewahren, während wir moderne Technologien einsetzen, um Energieeffizienz und Wohnkomfort zu verbessern. Die Sanierungsarbeiten umfassen die Restaurierung der Fassade unter Denkmalschutzauflagen, die Erneuerung der Elektro- und Wasserinstallationen sowie die Dämmung der Außenwände und des Daches. Besondere Aufmerksamkeit wird der sorgfältigen Auswahl von Materialien gewidmet, die sowohl historisch authentisch als auch umweltfreundlich sind. Durch die Kombination traditioneller Handwerkstechniken mit modernster Technologie schaffen wir ein energieeffizientes Zuhause, das die Geschichte atmet. Das Projekt wird in enger Zusammenarbeit mit Denkmalschutzbehörden durchgeführt, um sicherzustellen, dass alle Renovierungsarbeiten den gesetzlichen Anforderungen entsprechen. Unsere Vision ist es, eine Brücke zwischen Vergangenheit und Zukunft zu schlagen und einen Wohnraum zu schaffen, der Generationen überdauert.',
          '08.04.2026',
          ['assets/images/construction1.png', 'assets/images/construction2.png'],
        ),
        ProjectReport(
          'Heizkörperinstallation 2',
          'Installation neuer Heizkörper im gesamten Gebäude',
          '08.04.2026',
          ['assets/images/construction1.png', 'assets/images/construction2.png'],
        ),
        ProjectReport(
          'Heizkörperinstallation3 ',
          'Installation neuer Heizkörper im gesamten Gebäude',
          '08.04.2026',
          ['assets/images/construction1.png', 'assets/images/construction2.png'],
        ),
      ],
    ),
    const CustomeProject(
      'Gartengestaltung Grünwald',
      'Landschaftsgestaltung inklusive Teichanlage für einen Privatgarten. Status: Abgeschlossen. 25.04.2024 - 10.05.2024',
      false,
      20000,
      17,
      '25.04.2024 - 10.05.2024',
      6,
      122000,
      [
        ProjectReport(
          'Heizkörperinstallation',
          'Im Herzen Berlins steht ein historisches Gebäude, das dringend einer Sanierung bedarf. Unser Projektziel ist es, den Charme des alten Gebäudes zu bewahren, während wir moderne Technologien einsetzen, um Energieeffizienz und Wohnkomfort zu verbessern. Die Sanierungsarbeiten umfassen die Restaurierung der Fassade unter Denkmalschutzauflagen, die Erneuerung der Elektro- und Wasserinstallationen sowie die Dämmung der Außenwände und des Daches. Besondere Aufmerksamkeit wird der sorgfältigen Auswahl von Materialien gewidmet, die sowohl historisch authentisch als auch umweltfreundlich sind. Durch die Kombination traditioneller Handwerkstechniken mit modernster Technologie schaffen wir ein energieeffizientes Zuhause, das die Geschichte atmet. Das Projekt wird in enger Zusammenarbeit mit Denkmalschutzbehörden durchgeführt, um sicherzustellen, dass alle Renovierungsarbeiten den gesetzlichen Anforderungen entsprechen. Unsere Vision ist es, eine Brücke zwischen Vergangenheit und Zukunft zu schlagen und einen Wohnraum zu schaffen, der Generationen überdauert.',
          '08.04.2026',
          ['assets/images/construction1.png', 'assets/images/construction2.png'],
        ),
        ProjectReport(
          'Heizkörperinstallation 2',
          'Installation neuer Heizkörper im gesamten Gebäude',
          '08.04.2026',
          ['assets/images/construction1.png', 'assets/images/construction2.png'],
        ),
        ProjectReport(
          'Heizkörperinstallation3 ',
          'Installation neuer Heizkörper im gesamten Gebäude',
          '08.04.2026',
          ['assets/images/construction1.png', 'assets/images/construction2.png'],
        ),
      ],
    ),
    const CustomeProject(
      'Fliesenlegung Penthouse Richter',
      'Hochwertige Fliesenverlegung in einem Luxus-Penthouse. Status: Abgeschlossen. 03.04.2024 - 18.04.2024',
      false,
      20000,
      18,
      '03.04.2024 - 18.04.2024',
      7,
      122000,
      [
        ProjectReport(
          'Heizkörperinstallation',
          'Im Herzen Berlins steht ein historisches Gebäude, das dringend einer Sanierung bedarf. Unser Projektziel ist es, den Charme des alten Gebäudes zu bewahren, während wir moderne Technologien einsetzen, um Energieeffizienz und Wohnkomfort zu verbessern. Die Sanierungsarbeiten umfassen die Restaurierung der Fassade unter Denkmalschutzauflagen, die Erneuerung der Elektro- und Wasserinstallationen sowie die Dämmung der Außenwände und des Daches. Besondere Aufmerksamkeit wird der sorgfältigen Auswahl von Materialien gewidmet, die sowohl historisch authentisch als auch umweltfreundlich sind. Durch die Kombination traditioneller Handwerkstechniken mit modernster Technologie schaffen wir ein energieeffizientes Zuhause, das die Geschichte atmet. Das Projekt wird in enger Zusammenarbeit mit Denkmalschutzbehörden durchgeführt, um sicherzustellen, dass alle Renovierungsarbeiten den gesetzlichen Anforderungen entsprechen. Unsere Vision ist es, eine Brücke zwischen Vergangenheit und Zukunft zu schlagen und einen Wohnraum zu schaffen, der Generationen überdauert.',
          '08.04.2026',
          ['assets/images/construction1.png', 'assets/images/construction2.png'],
        ),
        ProjectReport(
          'Heizkörperinstallation 2',
          'Installation neuer Heizkörper im gesamten Gebäude',
          '08.04.2026',
          ['assets/images/construction1.png', 'assets/images/construction2.png'],
        ),
        ProjectReport(
          'Heizkörperinstallation3 ',
          'Installation neuer Heizkörper im gesamten Gebäude',
          '08.04.2026',
          ['assets/images/construction1.png', 'assets/images/construction2.png'],
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenWidthInPercent = (MediaQuery.of(context).size.width / 100);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: screenWidthInPercent * 2),
            // ignore: sized_box_for_whitespace
            Container(
              width: screenWidthInPercent * 70,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    const Expanded(
                      flex: 8,
                      child: Text(
                        'Projekt',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Expanded(
                      flex: 8,
                      child: Text(
                        'Status',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        //    textAlign: TextAlign.right,
                      ),
                    ),
                    //     const Spacer(),
                    const Expanded(
                      flex: 8,
                      child: Text(
                        'Zeitraum',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    //        const Spacer(),
                    const Expanded(
                      flex: 8,
                      child: Text(
                        '',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.right,
                      ), //Placeholder so the spacers space accordingly.
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: screenWidth > 600 ? double.infinity : null,
          height: MediaQuery.of(context).size.height / 3,
          child: ListView.builder(
            itemCount: project.length,
            itemBuilder: (_, index) => ProjectCard(
              project[index],
              isFirst: index == 0,
              isLast: index == project.length,
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
