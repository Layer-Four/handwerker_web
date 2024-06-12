import 'package:flutter/material.dart';
import '../../../models/project_models/customer_projekt_model/custom_project.dart';
import '../../shared_widgets/project_details.dart';

// ignore: must_be_immutable
class ProjectCard extends StatefulWidget {
  final CustomeProject report;

  const ProjectCard(
    this.report, {
    super.key,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool isContainerOpen = false;

  @override
  Widget build(BuildContext context) {
    final screenWidthInPercent = (MediaQuery.of(context).size.width / 100);
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: screenWidthInPercent * 2),
            Container(
              // width: double.infinity,
              width: screenWidthInPercent * 70,
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide()),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isContainerOpen = !isContainerOpen;
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 8,
                        child: Text(widget.report.customer),
                      ),
                      //  const Spacer(),
                      Expanded(
                        flex: 8,
                        child: widget.report.status
                            ? const Text(
                                'Abgeschlossen',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.green,
                                ),
                              )
                            : const Text(
                                'Offen',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.orange,
                                ),
                              ),
                      ),
                      //   const Spacer(),
                      Expanded(
                        flex: 8,
                        child: Text(
                          widget.report.projectTimeWindow,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      //  const Spacer(),
                      Expanded(
                        flex: 8,
                        child: Text(
                          '${widget.report.revenue},- €',
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Icon(isContainerOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        isContainerOpen ? ProjectDetails(widget.report) : const SizedBox.shrink(),
      ],
    );
  }
}
