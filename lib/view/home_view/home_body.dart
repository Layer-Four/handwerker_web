import 'package:flutter/material.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) => SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Stack(
            alignment:
                Alignment.center, // Align the text in the center of the image
            children: [
              Image.asset('assets/images/dashboardpreview.png'), // Your image
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                color:
                    Colors.black54, // Semi-transparent background for the text
                child: const Text(
                  'PREVIEW',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
