import 'package:flutter/material.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) => SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset('assets/images/dashboardpreview.png'),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                color: Colors.black54,
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
