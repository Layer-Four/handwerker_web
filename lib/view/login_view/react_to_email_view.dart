import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';
import '../shared_widgets/symetric_button_widget.dart';

class ReactToEmailView extends StatelessWidget {
  const ReactToEmailView({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(padding: EdgeInsets.all(50)),
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: SizedBox(
                  height: 44,
                  child: Image.asset('assets/images/img_techtool.png'),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(52.0),
                child: Text('Bitte bestätigen sie das sie Ihr Passwort zurücksetzen möchten'),
              ),
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: SymmetricButton(
                  text: 'Absenden',
                  onPressed: () => Navigator.of(context).pushReplacementNamed(
                    AppRoutes.setPasswordScreen,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
