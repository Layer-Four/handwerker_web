import 'package:flutter/material.dart';

class ConsumableBody extends StatelessWidget {
  const ConsumableBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.brown,
      width: double.infinity,
      height: double.infinity,
      child: Center(child: Text('Material')),
    );
  }
}
