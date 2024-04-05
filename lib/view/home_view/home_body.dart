import 'package:flutter/material.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) => Container(
        color: Colors.blue,
        width: double.infinity,
        height: double.infinity,
        child: const Center(child: Text('Home')),
      );
}
