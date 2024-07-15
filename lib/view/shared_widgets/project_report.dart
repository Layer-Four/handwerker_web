


// TODO: DEAD Code,this Widget is unused




// import 'package:flutter/material.dart';
// import '../../models/project_models/customer_projekt_model/custom_project.dart';

// class ProjectReportScreen extends StatefulWidget {
//   final CustomeProject project;

//   const ProjectReportScreen({super.key, required this.project});

//   @override
//   State<ProjectReportScreen> createState() => _ProjectReportScreenState();
// }

// class _ProjectReportScreenState extends State<ProjectReportScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final projectReports = widget.project.projectReports;
//     final screenWidthInPercent = (MediaQuery.of(context).size.width / 100);

//     return Container(
//       width: screenWidthInPercent * 70,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.5),
//             spreadRadius: 5,
//             blurRadius: 7,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: projectReports.map((report) => buildReportWidget(report)).toList(),
//         ),
//       ),
//     );
//   }

//   Widget buildReportWidget(ProjectReport report) => Padding(
//         padding: const EdgeInsets.all(30.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Text(
//                   report.projectname,
//                   style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(width: 30),
//                 const Text(
//                   'Projektbericht',
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     flex: 1,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         const Text(
//                           'Datum',
//                           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                         ),
//                         const SizedBox(height: 10),
//                         Text(
//                           report.date,
//                           style: const TextStyle(fontSize: 18),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Expanded(
//                     flex: 3,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         const Text(
//                           'Beschreibung',
//                           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                         ),
//                         const SizedBox(height: 10),
//                         Text(
//                           report.description,
//                           style: const TextStyle(fontSize: 18),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(
//                     width: 50,
//                   ),
//                   Expanded(
//                     flex: 2,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         const Text(
//                           'Fotos',
//                           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                         ),
//                         const SizedBox(height: 10),
//                         GridView.builder(
//                           shrinkWrap: true,
//                           physics: const NeverScrollableScrollPhysics(),
//                           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: 2,
//                             crossAxisSpacing: 15,
//                             mainAxisSpacing: 20,
//                             childAspectRatio: 2,
//                           ),
//                           itemCount: report.imagePaths.length,
//                           itemBuilder: (context, index) => ClipRect(
//                             child: SizedBox(
//                               width: 200,
//                               height: 100,
//                               child: Image.asset(report.imagePaths[index], fit: BoxFit.cover),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ]),
//             const Divider(height: 30, thickness: 2),
//           ],
//         ),
//       );
// }
