import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 40,
        child: Image.asset(
          'assets/images/img_techtool.png',
        ),
      );
}
