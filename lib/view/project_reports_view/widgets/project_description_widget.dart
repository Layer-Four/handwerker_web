import 'package:flutter/material.dart';

class DescriptionFiedlWidget extends StatelessWidget {
  final String? description;
  const DescriptionFiedlWidget(this.description, {super.key});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text(
              'Beschreibung',
              style: TextStyle(fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
            Container(
              width: MediaQuery.of(context).size.width > 850
                  ? 400
                  : MediaQuery.of(context).size.width * 0.1,
              height: 100,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: SingleChildScrollView(child: Text(description!)),
            ),
          ],
        ),
      );
}
