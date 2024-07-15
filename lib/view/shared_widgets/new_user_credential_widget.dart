import 'package:flutter/material.dart';

import '../../constants/utilitis/utilitis.dart';
import 'symetric_button_widget.dart';

class NewUserDataWidget extends StatelessWidget {
  final Map<String, dynamic> e;
  final Function()? onAccept;
  final String? onAcceptTitel;
  const NewUserDataWidget({
    super.key,
    required Map<String, dynamic> userData,
    this.onAccept,
    this.onAcceptTitel,
  }) : e = userData;
  @override
  Widget build(BuildContext context) => Dialog(
        backgroundColor: Colors.white,
        child: SizedBox(
          height: 400,
          width: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      'Mitarbeiter:',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        '   ${e['userName']}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  children: [
                    Text(
                      'Passwort:',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        '     ${e['password']}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                      child: SymmetricButton(
                        text: 'Als PDF Herunterladen',
                        onPressed: () => Utilitis.writePDFAndDownload(e),
                      ),
                    ),
                    onAccept == null
                        ? const SizedBox.shrink()
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                            child: SymmetricButton(
                              text: onAcceptTitel ?? '',
                              onPressed: onAccept,
                            ),
                          )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
