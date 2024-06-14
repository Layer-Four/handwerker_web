import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../models/time_models/project_time_model/project_time_entry.dart';

class ProjectReportsShowWidget extends StatelessWidget {
  final List<ProjectTimeEntry> reports;
  const ProjectReportsShowWidget(this.reports, {super.key});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeadline(context),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.8 - 55,
              child: ListView.builder(
                itemCount: reports.length,
                itemBuilder: (context, i) => Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.10,
                          child: reports[i].startTimeDate == null
                              ? const SizedBox.shrink()
                              : Text(
                                  '${reports[i].startTimeDate!.day}.${reports[i].startTimeDate!.month}.${reports[i].startTimeDate!.year}',
                                  textAlign: TextAlign.center,
                                ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: reports[i].workDescription == null
                              ? const SizedBox.shrink()
                              : Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 3),
                                  child: SingleChildScrollView(
                                    child: Text(
                                      reports[i].workDescription!,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                        ),
                        SizedBox(
                          height: 150,
                          width: MediaQuery.of(context).size.width * 0.20,
                          child: reports[i].imagePathList.isEmpty
                              ? const SizedBox.shrink()
                              : ListView.builder(
                                  itemCount: reports[i].imagePathList.length,
                                  itemBuilder: (_, k) {
                                    log(reports[i].imagePathList[k]);
                                    log('https://r-wa-happ-be.azurewebsites.net/api/${reports[i].imagePathList[k]}');
                                    return Image.network(
                                      'https://r-wa-happ-be.azurewebsites.net/api/${reports[i].imagePathList[k]}',
                                      fit: BoxFit.contain,
                                      // width: MediaQuery.of(context).size.width * 0.18,
                                    );
                                  }),
                        ),
                      ],
                    ),
                    const Divider(height: 30, thickness: 2, indent: 20, endIndent: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      );

  SizedBox _buildHeadline(BuildContext context) => SizedBox(
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.10,
            child: Text(
              'Datum',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.45,
            child: Text(
              'Berichte',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.20,
            child: Text(
              'Fotors',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ));
}