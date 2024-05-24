import 'package:flutter/material.dart';
import '../shared_view_widgets/search_line_header.dart';
import 'widgets/custom_week_view.dart';

class WorkAssignmenView extends StatelessWidget {
  const WorkAssignmenView({super.key});

  @override
  Widget build(BuildContext context) => const Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SearchLineHeader(title: 'Stundenübersicht', searchbarEnabled: false),
            CustonWeekView(),
          ],
        ),
      );
}
