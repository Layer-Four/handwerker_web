import 'package:flutter/material.dart';

class ServiceHeadlineWidget extends StatelessWidget {
  const ServiceHeadlineWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(left: 4, top: 40, bottom: 24),
        child: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width > 1000
                  ? 400
                  : MediaQuery.of(context).size.width / 10 * 3,
              child: Text(
                'Leistung',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width > 1000
                  ? 400
                  : MediaQuery.of(context).size.width / 10 * 3,
              child: Text(
                'Preis/Std/€',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ],
        ),
      );
}
