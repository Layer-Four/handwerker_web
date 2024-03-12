import 'package:flutter/material.dart';

class DocumentBody extends StatelessWidget {
  const DocumentBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey,
      width: double.infinity,
      height: double.infinity,
      child: const Center(
        child: Text('Berichte'),
      ),
    );
  }
}
