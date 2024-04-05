import 'package:flutter/material.dart';
import 'doc_screen.dart';

class DocumentBody extends StatelessWidget {
  const DocumentBody({super.key});

  @override
  // TODO: why doesent rename and open this widget direct on ViewScreen?
  Widget build(BuildContext context) => Container(
        color: Colors.blueGrey,
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: MyApp(),
        ),
      );
}
