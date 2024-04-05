import 'package:flutter/material.dart';
import 'custom_project.dart';

class ProjectReportScreen extends StatefulWidget {
  final CustomeProject project;

  ProjectReportScreen({super.key, required this.project});

  @override
  State<ProjectReportScreen> createState() => _ProjectReportScreenState();
}

class _ProjectReportScreenState extends State<ProjectReportScreen> {
  @override
  Widget build(BuildContext context) {
    // Assuming `projectReports` is a list of `ProjectReport` objects in `CustomeProject`
    final projectReports = widget.project.projectReports;
    final screenWidthInPercent = (MediaQuery.of(context).size.width / 100);

    return Container(
      width: screenWidthInPercent * 70,
      //  margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: SingleChildScrollView(
        // Use SingleChildScrollView to allow for variable length content
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: projectReports.map((report) => buildReportWidget(report)).toList(),
        ),
      ),
    );
  }

  Widget buildReportWidget(ProjectReport report) {
    int numberOfRows = (report.imagePaths.length / 2).ceil();

    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                report.projectname,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 30),
              const Text(
                'Projektbericht',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, children: [
            Expanded(
              flex: 1,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'Datum',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      report.date,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'Beschreibung',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    report.description,
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 50,
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'Fotos',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  GridView.builder(
                    shrinkWrap: true,
                    // Use this to prevent the GridView from expanding infinitely.
                    physics: const NeverScrollableScrollPhysics(),
                    // Use this to disable scroll within the GridView.
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Two images per row.
                      crossAxisSpacing: 15, // Desired spacing between images horizontally.
                      mainAxisSpacing: 20, // Desired spacing between rows.
                      childAspectRatio: 2, // Aspect ratio of each item (width / height).
                    ),
                    itemCount: report.imagePaths.length,
                    itemBuilder: (context, index) => ClipRect(
                      child: Container(
                        width: 200, // Desired width of each image.
                        height: 100, // Desired height of each image.
                        child: Image.asset(
                          report.imagePaths[index],
                          fit: BoxFit.cover, // This ensures the image covers the container, cropping if necessary.
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),

          const Divider(height: 30, thickness: 2), // Optional: Adds a divider between reports
        ],
      ),
    );
  }
}
