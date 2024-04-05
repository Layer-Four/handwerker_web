import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  final Widget body;
  final String imageName;

  const BackgroundWidget({super.key, required this.body, required this.imageName});

  @override
  Widget build(BuildContext context) => Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/$imageName'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: double.infinity,
            decoration: const BoxDecoration(
              color: Color.fromARGB(75, 126, 122, 122),
            ),
            padding: const EdgeInsets.all(20),
            child: body,
          )
        ],
      );
}
