import 'package:flutter/material.dart';

class UserRowHeadLine extends StatelessWidget {
  const UserRowHeadLine({super.key});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(left: 4, top: 40, bottom: 24),
        child: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width > 1200
                  ? 300
                  : MediaQuery.of(context).size.width * 0.2,
              child: Text(
                'Name',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width > 950
                  ? 150
                  : MediaQuery.of(context).size.width * 0.2,
              child: Text(
                'Rolle',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ],
        ),
      );
}
