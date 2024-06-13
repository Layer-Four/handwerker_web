import 'package:flutter/material.dart';

class DescriptionFiedlWidget extends StatelessWidget {
  final String? description;
  const DescriptionFiedlWidget(this.description, {super.key});

  @override
  Widget build(BuildContext context) => Expanded(
        flex: 1,
        child: description == null
            ? const SizedBox.shrink()
            : Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    const Text(
                      'Beschreibung',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.fromLTRB(5, 5, 5, 20),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                      ),
                      child: Text(description!),
                    ),
                  ],
                ),
              ),
      );
}
