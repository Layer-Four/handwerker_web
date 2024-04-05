import 'package:flutter/material.dart';
import 'custom_project.dart';

// ignore: must_be_immutable
class ProjectCard extends StatefulWidget {
  final CustomeProject project;
  final bool isFirst;
  final bool isLast;
  bool isContainerOpen;

  ProjectCard(
    this.project, {
    super.key,
    this.isFirst = false,
    this.isLast = false,
    this.isContainerOpen = false,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  @override
  Widget build(BuildContext context) {
    final screenWidthInPercent = (MediaQuery.of(context).size.width / 100);

    return Row(
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
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
                  flex: 2,
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
                  flex: 2,
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
                  flex: 2,
                  // ignore: avoid_unnecessary_containers
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
              ],
            ),
          ),
        ),
      ],
    );
  }
}
