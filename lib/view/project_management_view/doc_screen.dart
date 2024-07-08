/*// TODO: Delete Screen when is unused
// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../models/project_models/customer_projekt_model/custom_project.dart';
// import '../administration_view/customers_view/widgets/customer_card.dart';
// import '../administration_view/project_management_view/widgets/edit_project.dart';
// import '../shared_widgets/search_line_header.dart';

// class ProjectManagementBody extends ConsumerStatefulWidget {
//   //StatelessWidget
//   const ProjectManagementBody({super.key});

//   @override
//   ConsumerState<ProjectManagementBody> createState() => _ProjectManagementBodyState();
// }

// class _ProjectManagementBodyState extends ConsumerState<ProjectManagementBody> {
//   //Call fetch infos here

//   //  const Text('Berichte', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//   bool isAddNewProject = false;
//   int editingProjectIndex = -1;

//   @override
//   Widget build(BuildContext context) {
//     //, WidgetRef ref
//     final screenWidth = MediaQuery.of(context).size.width;
//     //ref.read(customerProjectProvider.notifier).fetchInfos(); //todo: implement api

// /*    late List<TextEditingController> _controllers;
//     late List<bool> _isEditing;

//     void _addNewConsumable() {
//       setState(() {
//         final newController = TextEditingController();
//         _controllers.add(newController);
//         _isEditing.add(true);
//       });
//     }*/

//     return Container(
//       color: Colors.white,
//       child: Padding(
//         padding: const EdgeInsets.fromLTRB(75, 30, 65, 30),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               const SearchLineHeader(title: 'Projektverwaltung'),
//               const SizedBox(
//                 height: 60,
//               ),
//               const Padding(
//                 padding: EdgeInsets.all(10.0),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Text(
//                       'Name',
//                       style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               SizedBox(
//                 width: screenWidth > 600 ? double.infinity : null,
//                 height: MediaQuery.of(context).size.height / 2 - 100,
//                 /*isAddNewProject
//                     ? MediaQuery.of(context).size.height / 3
//                     : MediaQuery.of(context).size.height - 300,*/
//                 child: ListView.builder(
//                   itemCount: project.length,
//                   itemBuilder: (_, index) => GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         isAddNewProject = !isAddNewProject;
//                         editingProjectIndex = index;
//                       });
//                     },
//                     child: CustomerCard(project[index]),
//                   ),
//                 ),
//               ),
//               Container(
//                 alignment: Alignment.topLeft,
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(50),
//                   child: SizedBox(
//                     height: 30,
//                     width: 30,
//                     child: Material(
//                       color: Colors.orange,
//                       borderRadius: BorderRadius.circular(50),
//                       child: Center(
//                         child: IconButton(
//                           padding: EdgeInsets.zero,
//                           icon: Icon(
//                             isAddNewProject ? Icons.remove : Icons.add,
//                             color: Colors.white,
//                           ),
//                           onPressed: () {
//                             setState(() {
//                               isAddNewProject = !isAddNewProject;
//                             });
//                           },
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Visibility(
//                 visible: isAddNewProject,
//                 child: SizedBox(
//                   // alignment: Alignment.topLeft,
//                   height: MediaQuery.of(context).size.height / 3,
//                   width: screenWidth / 2,
//                   child: AddNewProject.withDefaultVM(
//                     onSave: () {
//                       log('save');
//                       //Todo: Call api for saving
//                       //If Edit was clicked (therefore index != -1), also pass which customer is to be edited
//                       //Might be a different apie then
//                       /*                  setState(() {
//                         _addNewConsumable();
//                       });*/
//                     },
//                     onCancel: () {
//                       log('cancel');
//                       setState(() {
//                         isAddNewProject = !isAddNewProject;
//                       });
//                     },
//                     project: editingProjectIndex != -1
//                         ? project[editingProjectIndex]
//                         : null, //If a project was clicked instead of the + icon, we pass the project and prefill the data
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// final List<CustomeProject> project = [
//   const CustomeProject(
//     'Layer Four GmbH',
//     'Austausch der Heizungsanlage',
//     false,
//     60000,
//     11,
//     '01.01.2024 - 01.06.2025',
//     1009,
//     1009,
//     [
//       ProjectReport(
//         'Heizkörperinstallation',
//         'Im Herzen Berlins steht ein historisches Gebäude, das dringend einer Sanierung bedarf. Unser Projektziel ist es, den Charme des alten Gebäudes zu bewahren, während wir moderne Technologien einsetzen, um Energieeffizienz und Wohnkomfort zu verbessern. Die Sanierungsarbeiten umfassen die Restaurierung der Fassade unter Denkmalschutzauflagen, die Erneuerung der Elektro- und Wasserinstallationen sowie die Dämmung der Außenwände und des Daches. Besondere Aufmerksamkeit wird der sorgfältigen Auswahl von Materialien gewidmet, die sowohl historisch authentisch als auch umweltfreundlich sind. Durch die Kombination traditioneller Handwerkstechniken mit modernster Technologie schaffen wir ein energieeffizientes Zuhause, das die Geschichte atmet. Das Projekt wird in enger Zusammenarbeit mit Denkmalschutzbehörden durchgeführt, um sicherzustellen, dass alle Renovierungsarbeiten den gesetzlichen Anforderungen entsprechen. Unsere Vision ist es, eine Brücke zwischen Vergangenheit und Zukunft zu schlagen und einen Wohnraum zu schaffen, der Generationen überdauert.',
//         '08.04.2026',
//         ['assets/images/construction1.png', 'assets/images/construction2.png'],
//       ),
//       ProjectReport(
//         'Heizkörperinstallation 2',
//         'Installation neuer Heizkörper im gesamten Gebäude',
//         '08.04.2026',
//         ['assets/images/construction1.png', 'assets/images/construction2.png'],
//       ),
//       ProjectReport(
//         'Heizkörperinstallation3 ',
//         'Installation neuer Heizkörper im gesamten Gebäude',
//         '08.04.2026',
//         ['assets/images/construction1.png', 'assets/images/construction2.png'],
//       ),
//     ],
//   ),
//   const CustomeProject(
//     'Berlin AG',
//     'Tisch gebaut',
//     true,
//     20000,
//     11,
//     '01.01.2024 - 01.06.2025',
//     2099,
//     9000,
//     [
//       ProjectReport(
//         'Tischlerei',
//         'Herstellung eines maßgeschneiderten Tisches aus Eichenholz',
//         '08.04.2026',
//         ['assets/images/construction1.png', 'assets/images/construction2.png'],
//       ),
//     ],
//   ),
//   const CustomeProject(
//     'Creative GmbH',
//     'Fenster eingesetzt',
//     true,
//     20000,
//     11,
//     '01.01.2024 - 01.06.2025',
//     2,
//     900000,
//     [
//       ProjectReport(
//         'Fensterinstallation',
//         'Einsetzen der Fenster in Neubau',
//         '08.04.2026',
//         ['assets/images/construction1.png', 'assets/images/construction2.png'],
//       ),
//     ],
//   ),
//   const CustomeProject(
//     'Fio Bestmann',
//     'Steinloch 43\n22880, Hamburg',
//     true,
//     20000,
//     2,
//     '01.01.2024 - 01.06.2025',
//     2,
//     1009,
//     [
//       ProjectReport(
//         'Sanierung',
//         'Sanierung des Steinlochs',
//         '08.04.2026',
//         ['assets/images/construction1.png', 'assets/images/construction2.png'],
//       ),
//     ],
//   ),
//   const CustomeProject(
//     'Florian Hensel',
//     'Große Straße 54\n22449, Kassel',
//     true,
//     20000,
//     2,
//     '01.01.2024 - 01.06.2025',
//     2,
//     122000,
//     [
//       ProjectReport(
//         'Außenanlagen',
//         'Gestaltung der Außenanlagen',
//         '08.04.2026',
//         ['assets/images/construction1.png', 'assets/images/construction2.png', 'assets/images/construction2.png'],
//       ),
//       ProjectReport(
//         'Außenanlagen',
//         'Gestaltung der Außenanlagen',
//         '08.04.2026',
//         ['assets/images/construction1.png', 'assets/images/construction2.png', 'assets/images/construction2.png'],
//       ),
//       ProjectReport(
//         'Außenanlagen',
//         'Gestaltung der Außenanlagen',
//         '08.04.2026',
//         ['assets/images/construction1.png', 'assets/images/construction2.png', 'assets/images/construction2.png'],
//       ),
//     ],
//   ),
// ];
// final List<CustomeProject> project = [
//   const CustomeProject(
//     'Elektrische Erneuerung Müller',
//     'Komplette Erneuerung der Elektrik in einem Altbau. Status: Geplant. 01.05.2024 - 15.05.2024',
//     false,
//     60000,
//     11,
//     '01.05.2024 - 15.05.2024',
//     1009,
//     1009,
//   ),
//   const CustomeProject(
//     'Sanitärinstallation Villa Schmidt',
//     'Installation neuer Sanitäranlagen in einer neu gebauten Villa. Status: In Arbeit. 10.04.2024 - 30.04.2024',
//     true,
//     20000,
//     12,
//     '10.04.2024 - 30.04.2024',
//     2099,
//     9000,
//   ),
//   const CustomeProject(
//     'Fassadenanstrich Meier',
//     'Neuanstrich der Außenfassade eines Einfamilienhauses. Status: In Arbeit. 20.04.2024 - 05.05.2024',
//     true,
//     20000,
//     13,
//     '20.04.2024 - 05.05.2024',
//     2,
//     900000,
//   ),
//   const CustomeProject(
//     'Küchenmontage Weber',
//     'Maßanfertigung und Installation einer neuen Küche. Status: Geplant. 15.05.2024 - 30.05.2024',
//     false,
//     20000,
//     14,
//     '15.05.2024 - 30.05.2024',
//     3,
//     1009,
//   ),
//   const CustomeProject(
//     'Dachreparatur Leibniz Gymnasium',
//     'Reparatur und Isolierung des Schuldachs. Status: Geplant. 01.06.2024 - 15.07.2024',
//     false,
//     20000,
//     15,
//     '01.06.2024 - 15.07.2024',
//     4,
//     122000,
//   ),
//   const CustomeProject(
//     'Badezimmerrenovierung Bauer',
//     'Komplettsanierung eines Badezimmers inklusive moderner Fliesen. Status: Geplant. 05.06.2024 - 20.06.2024',
//     false,
//     20000,
//     16,
//     '05.06.2024 - 20.06.2024',
//     5,
//     122000,
//   ),
//   const CustomeProject(
//     'Gartengestaltung Grünwald',
//     'Landschaftsgestaltung inklusive Teichanlage für einen Privatgarten. Status: Abgeschlossen. 25.04.2024 - 10.05.2024',
//     false,
//     20000,
//     17,
//     '25.04.2024 - 10.05.2024',
//     6,
//     122000,
//   ),
//   const CustomeProject(
//     'Fliesenlegung Penthouse Richter',
//     'Hochwertige Fliesenverlegung in einem Luxus-Penthouse. Status: Abgeschlossen. 03.04.2024 - 18.04.2024',
//     false,
//     20000,
//     18,
//     '03.04.2024 - 18.04.2024',
//     7,
//     122000,
//   ),
// ];
// // final List<CustomeProject> project = [
//   const CustomeProject(
//     'Project X',
//     'Austausch der\nHeizungsanlage',
//     false,
//     60000,
//     11,
//     '01.01.2024 - 01.06.2025',
//     1009,
//     1009,
//   ),
//   const CustomeProject(
//     'Project Y',
//     'Tisch gebaut',
//     true,
//     20000,
//     11,
//     '01.01.2024 - 01.06.2025',
//     2099,
//     9000,
//   ),
//   const CustomeProject(
//     'Experiment R',
//     'Fenster eingesetzt',
//     true,
//     20000,
//     11,
//     '01.01.2024 - 01.06.2025',
//     2,
//     900000,
//   ),
//   const CustomeProject(
//     'Fio Bestmann',
//     'Steinloch 43\n22880, Hamburg',
//     true,
//     20000,
//     2,
//     '01.01.2024 - 01.06.2025',
//     2,
//     1009,
//   ),
//   const CustomeProject(
//     'Florian hensel',
//     'große Straße 54\n22449, Kassel',
//     true,
//     20.000,
//     2,
//     '01.01.2024 - 01.06.2025',
//     2,
//     122000,
//   ),
// ];*/
