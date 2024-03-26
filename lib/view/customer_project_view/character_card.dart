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
    final screenWihdthinProzents = (MediaQuery.of(context).size.width / 100);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          top: const BorderSide(),
          // left: const BorderSide(),
          // right: const BorderSide(),
          bottom: widget.isLast ? const BorderSide() : BorderSide.none,
        ),
      ),
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
                      ),
                    ),
                    SizedBox(
                      width: screenWihdthinProzents * 11,
                      child: Text(
                        '${widget.project.projectNumber}',
                        textAlign: TextAlign.right,
                      ),
                    ),
                    SizedBox(
                      width: screenWihdthinProzents * 11,
                      child: Text(
                        '${widget.project.projectNumber} EUR',
                        textAlign: TextAlign.right,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      width: screenWihdthinProzents * 11,
                      child: Text(
                        '${widget.project.totalTime} EUR',
                        textAlign: TextAlign.right,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      width: screenWihdthinProzents * 11,
                      child: Text(
                        '${widget.project.costItems} EUR',
                        textAlign: TextAlign.right,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      width: screenWihdthinProzents * 11,
                      child: Text(
                        '${widget.project.revenue} EUR',
                        textAlign: TextAlign.right,
                        overflow: TextOverflow.ellipsis,
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
              Row(
                children: <Widget>[
                  const Flexible(
                    flex: 4, // 20%
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Berlin AG",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Kundennummer:134D8282',
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text('Kontakt'),
                        Text(
                          'Ansprechpartner:Jürgen Holz\nTelefon:016037372\nE-Mail:kunden@handwerker.de',
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text('Adresse:'),
                        Text(
                          'Berliner Straße 234\n2290 Berlin',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 2, // 60%
                    child: Container(
                      height: 160,
                      decoration: BoxDecoration(border: Border.all()),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('Der Kunde\nist blöd'),
                          Text('Antwortet nie'),
                          Text('Zahlt nicht'),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 3, // 20%
                    child: Column(
                      children: [
                        const Center(child: Text("2")),
                        const SizedBox(
                          height: 22,
                        ),
                        Container(
                          height: 100,
                          width: 200,
                          decoration: BoxDecoration(border: Border.all()),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("1 Begründung Herkules"),
                              Text("2 Begründung Schlosswiese"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 1, // 60%
                    child: Container(color: Colors.green),
                  ),
                  Flexible(
                    flex: 1, // 60%
                    child: Container(
                        color: const Color.fromARGB(255, 175, 76, 134)),
                  ),
                  Flexible(
                    flex: 1, // 60%
                    child: Container(color: Colors.green),
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }
}
