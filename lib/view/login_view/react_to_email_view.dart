import 'package:flutter/material.dart';

import '../../constants/themes/app_color.dart';
import '../shared_widgets/symetric_button_widget.dart';

class ReactToEmailView extends StatefulWidget {
  const ReactToEmailView({super.key});

  @override
  State<ReactToEmailView> createState() => _ReactToEmailViewState();
}

class _ReactToEmailViewState extends State<ReactToEmailView> {
  bool _isAccepted = false;
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
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
                padding: EdgeInsets.all(32.0),
                child: Text('Bitte bestätigen sie das sie Ihr Passwort zurücksetzen möchten'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Checkbox(
                  value: _isAccepted,
                  activeColor: AppColor.kPrimaryButtonColor,
                  onChanged: (_) {
                    setState(() => _isAccepted = !_isAccepted);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: SymmetricButton(
                  text: 'Absenden',
                  onPressed: () {},
                ),
              )
            ],
          ),
        ),
      );
}
