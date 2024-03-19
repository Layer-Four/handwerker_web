import 'package:flutter/material.dart';
import 'package:handwerker_web/view/customer_project_view/custom_project.dart';

// ignore: must_be_immutable
class CharacterCard extends StatefulWidget {
  final CustomeProject project;
  final bool isLast;
  bool isContainerOpen;
  CharacterCard(
    this.project, {
    super.key,
    this.isLast = false,
    this.isContainerOpen = false,
  });

  @override
  State<CharacterCard> createState() => _CharacterCardState();
}

class _CharacterCardState extends State<CharacterCard> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // final screenHeight = MediaQuery.of(context).size.height;

    // Calculate the percentage of screen width
    // final screenWidthPercentage = screenWidth / 100;
    final screenWihdthinProzents = (MediaQuery.of(context).size.width / 100);
    // final screenHeightnProzents = (MediaQuery.of(context).size.height / 100);

    return Container(
      // width: screenWihdthinProzents * 100,
      width: screenWidth > 600 ? double.infinity : null,

      decoration: BoxDecoration(
        border: Border(
          top: const BorderSide(),
          left: const BorderSide(),
          right: const BorderSide(),
          bottom: widget.isLast ? const BorderSide() : BorderSide.none,
        ),
      ),
      // height: widget.isLast ? 160 : null,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    widget.isContainerOpen = !widget.isContainerOpen;
                  });
                },
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: screenWihdthinProzents * 25,
                        child: Row(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                widget.project.name,
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                widget.project.customer,
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: screenWihdthinProzents * 20,
                        child: Text(
                          widget.project.description,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        width: screenWihdthinProzents * 15,
                        child: Text(
                          '${widget.project.lastChange.day}.${widget.project.lastChange.month}.${widget.project.lastChange.year}',
                          textAlign: TextAlign.right,
                        ),
                      ),
                      SizedBox(
                        width: screenWihdthinProzents * 20,
                        child: Text(
                          '${widget.project.revenue} EUR',
                          textAlign: TextAlign.right,
                        ),
                      ),
                      Icon(widget.isContainerOpen
                          ? Icons.arrow_drop_up
                          : Icons.arrow_drop_down)
                    ],
                  ),
                ),
              ),
              if (widget.isContainerOpen)
                Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                  ),
                  child: const Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(child: Text('23.09.2024')),
                          Expanded(child: Text('Montage')),
                          Expanded(child: Text('8 h')),
                          Expanded(child: Text('10m Leisten ')),
                          Row(
                            children: [
                              Text('2.0000'),
                              Icon(Icons.image),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(child: Text('23.09.2024')),
                          Expanded(child: Text('Montage')),
                          Expanded(child: Text('8 h')),
                          Expanded(child: Text('10m Leisten ')),
                          Row(
                            children: [
                              Text('2.0000'),
                              Icon(Icons.image),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: Text('23.09.2024')),
                          Expanded(child: Text('Montage')),
                          Expanded(child: Text('8 h')),
                          Expanded(child: Text('10m Leisten ')),
                          Row(
                            children: [
                              Text('2.0000'),
                              Icon(Icons.image),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
