import 'package:flutter/material.dart';
import 'package:handwerker_web/view/customer_project_view/doc_screen.dart';

class DocumentBody extends StatelessWidget {
  const DocumentBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey,
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: MyApp(),
      ),
    );
  }
}
