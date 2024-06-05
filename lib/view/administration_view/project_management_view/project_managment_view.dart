import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/project_models/customer_projekt_model/custom_project.dart';
import '../../shared_view_widgets/search_line_header.dart';
import '../../users_view/widgets/add_button_widget.dart';
import 'customer_card.dart';
import 'edit_project.dart';

class ProjectManagementBody extends ConsumerStatefulWidget {
  //StatelessWidget
  const ProjectManagementBody({super.key});

  @override
  ConsumerState<ProjectManagementBody> createState() => _ProjectManagementBodyState();
}

class _ProjectManagementBodyState extends ConsumerState<ProjectManagementBody> {
  //Call fetch infos here

  //  const Text('Berichte', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
  bool isAddNewProject = false;
  int editingProjectIndex = -1;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(75, 30, 65, 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SearchLineHeader(title: 'Projektverwaltung'),
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
                /*isAddNewProject
                    ? MediaQuery.of(context).size.height / 3
                    : MediaQuery.of(context).size.height - 300,*/
                child: ListView.builder(
                  itemCount: project.length,
                  itemBuilder: (_, index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        isAddNewProject = !isAddNewProject;
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AddButton(
                  onTap: () {
                    setState(() {
                      isAddNewProject = !isAddNewProject;
                    });
                  },
                ),
              ),
              Visibility(
                visible: isAddNewProject,
                child: SizedBox(
                  // alignment: Alignment.topLeft,
                  height: MediaQuery.of(context).size.height / 3,
                  width: screenWidth / 2,
                  child: AddNewProject(
                    onSave: () {},
                    onCancel: () {
                      setState(() {
                        isAddNewProject = !isAddNewProject;
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
    'Elektrische Erneuerung Müller',
    'Komplette Erneuerung der Elektrik in einem Altbau. Status: Geplant. 01.05.2024 - 15.05.2024',
    false,
    60000,
    11,
    '01.05.2024 - 15.05.2024',
    1009,
    1009,
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
  ),
];
