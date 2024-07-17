import 'package:flutter/material.dart';

class ConsumableHeader extends StatelessWidget {
  const ConsumableHeader({super.key});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(left: 8, top: 40, bottom: 24),
        child: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width > 1000
                  ? 200
                  : MediaQuery.of(context).size.width / 10 * 1.8,
              child: Text(
                'Material',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width > 1000
                  ? 200
                  : MediaQuery.of(context).size.width / 10 * 1.8,
              child: Text(
                'Menge',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width > 1000
                  ? 200
                  : MediaQuery.of(context).size.width / 10 * 1.8,
              child: Text(
                'Einheit',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width > 1000
                  ? 200
                  : MediaQuery.of(context).size.width / 10 * 1.8,
              child: Text(
                'Preis/€',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      );
}
