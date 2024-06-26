import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../constants/utilitis/utilitis.dart';
import '../../provider/user_provider/user_administration/user_administration._provider.dart';
import '../../routes/app_routes.dart';
import '../shared_widgets/symetric_button_widget.dart';

class ReactToEmailView extends StatefulWidget {
  const ReactToEmailView({super.key});

  @override
  State<ReactToEmailView> createState() => _ReactToEmailViewState();
}

class _ReactToEmailViewState extends State<ReactToEmailView> {
  final TextEditingController _userNameCtr = TextEditingController();
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
                padding: EdgeInsets.all(32.0),
                child: Text(
                  'Bitte bestätigen sie mit der Eingbae Ihres Nutzernamen das sie Ihr Passwort zurücksetzen möchten',
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(50),
                child: TextField(
                  controller: _userNameCtr,
                  decoration: Utilitis.textFieldDecoration('Nutzername'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Consumer(
                    builder: (context, ref, child) => SymmetricButton(
                          text: 'Absenden',
                          onPressed: () {
                            if (_userNameCtr.text.isEmpty) {
                              return Utilitis.showSnackBar(context,
                                  'Bitter bestätigen sie zuerst mit ihrem Nutzernamen\nbevor sie auf Absenden Drücken');
                            }
                            ref
                                .read(userAdministrationProvider.notifier)
                                .resetPassword(_userNameCtr.text)
                                .then((e) {
                              Utilitis.showNewPasswordPopUp(
                                context,
                                e,
                                onAcceptTitel: 'Zurück Zur Startseite',
                                onAccept: () => Navigator.of(context)
                                    .pushReplacementNamed(AppRoutes.initialRoute),
                              );
                            });
                          },
                        )),
              ),
            ],
          ),
        ),
      );
}
