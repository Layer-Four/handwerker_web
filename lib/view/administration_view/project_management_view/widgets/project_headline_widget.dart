import 'package:flutter/material.dart';

class ProjectRowHeadline extends StatelessWidget {
  const ProjectRowHeadline({super.key});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(left: 8, top: 40, bottom: 24),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Name',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}
