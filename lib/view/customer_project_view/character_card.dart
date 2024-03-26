import 'package:flutter/material.dart';
import 'package:handwerker_web/view/customer_project_view/custom_project.dart';

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
          left: const BorderSide(),
          right: const BorderSide(),
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
              Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Berlin Ag',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              'KundenNummer:134D8282',
                              style: TextStyle(color: Colors.grey),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        SizedBox(width: screenWihdthinProzents * 11),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              '2',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Text('11 h'),
                        Text(
                          '1.099 EUR ',
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          '100.00 EUr EUR ',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Kontakt:',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                'Ansprechpartner:Jürgen Holz',
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text(
                                'Telefon:016037372',
                                style: TextStyle(color: Colors.grey),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                'E-mail:Kunde@handwerker.de',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 180,
                            width: 120,
                            decoration: BoxDecoration(border: Border.all()),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 1),
                                child: Text(
                                  'Der Kunde\nist blöd \nantwortet nie\nzahlt nicht',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                              '1 Begründung Herkules \n 2 Begründung Schlosswiese'),
                        ),
                        Column(
                          children: [
                            Text('5 h '),
                            Text('6 h '),
                          ],
                        ),
                        Column(
                          children: [
                            Text('1000 EUR  '),
                            Text('99 EUR '),
                          ],
                        ),
                        Column(
                          children: [
                            Text('10.000 EUR '),
                            Text('990.000 EUR '),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Kontakt:',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              'Adresse:',
                              style: TextStyle(color: Colors.grey),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              'Berliner Straße 234',
                              style: TextStyle(color: Colors.grey),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              '22990 Berlin',
                              style: TextStyle(color: Colors.grey),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
