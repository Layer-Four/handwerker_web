import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:handwerker_web/view/customer_project_view/custom_project.dart';
import 'package:handwerker_web/view/customer_project_view/project_details.dart';
import 'package:handwerker_web/view/customer_project_view/project_overview.dart';

// ignore: must_be_immutable
class ProjectCard extends StatefulWidget {
  final CustomeProject project;
  final bool isFirst;
  final bool isLast;

  ProjectCard(
    this.project, {
    super.key,
    this.isFirst = false,
    this.isLast = false,
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
              decoration: BoxDecoration(
                border: Border(
                  top: widget.isFirst ? BorderSide.none : const BorderSide(),
                  // left: const BorderSide(),
                  // right: const BorderSide(),
                  bottom: widget.isLast ? const BorderSide() : BorderSide.none,
                ),
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
                        child: Text(
                          widget.project.customer,
                          //    textAlign: TextAlign.right,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      //  const Spacer(),
                      Expanded(
                        flex: 8,
                        child: widget.project.status
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
                          widget.project.projectTimeWindow,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      //  const Spacer(),
                      Expanded(
                        flex: 8,
                        child: Container(
                          child: Text(
                            '${widget.project.revenue},- €',
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
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
        isContainerOpen
            ? ProjectDetails(
                widget.project,
              )
            : Container(),
      ],
    );
  }
}
