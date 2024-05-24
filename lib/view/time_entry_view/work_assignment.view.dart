import 'package:flutter/material.dart';
import '../shared_view_widgets/search_line_header.dart';
import 'widgets/custom_week_view.dart';
import 'widgets/left_button_widget.dart';

class WorkAssignmenView extends StatelessWidget {
  const WorkAssignmenView({super.key});

  @override
  Widget build(BuildContext context) => const Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Column(
          children: [
            SearchLineHeader(title: 'Stundenübersicht', searchbarEnabled: false),
            LeftButtonRow(),
            CustonWeekView(),
          ],
        ),
      );
}
