import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../constants/themes/app_color.dart';
import '../../../../models/service_models/service_vm/service_vm.dart';
import '../../../../provider/data_provider/service_provider/service_vm_provider.dart';
import '../../../shared_widgets/symetric_button_widget.dart';

class CreateServiceWidget extends StatefulWidget {
  final Function onReject;

  const CreateServiceWidget({
    required this.onReject,
    super.key,
  });

  @override
  State<CreateServiceWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CreateServiceWidget> {
  final TextEditingController _leistungController = TextEditingController();
  final TextEditingController _preisController = TextEditingController();
  ServiceVM _newService = const ServiceVM(name: '', hourlyRate: 0);

  @override
  void dispose() {
    _leistungController.dispose();
    _preisController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SizedBox(
        width: MediaQuery.of(context).size.width > 1000
            ? 800
            : MediaQuery.of(context).size.width / 10 * 8,
        child: Card(
          surfaceTintColor: Colors.white,
          elevation: 6,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  width: MediaQuery.of(context).size.width > 1000
                      ? 800
                      : MediaQuery.of(context).size.width / 10 * 8,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      'Neue Leistung anlegen',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(color: AppColor.kGrey),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width > 1000
                          ? 300
                          : MediaQuery.of(context).size.width / 10 * 3.5,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Leistung',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.bold)),
                            TextField(
                                controller: _leistungController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: const Color.fromARGB(211, 245, 241, 241),
                                  hintText: 'Leistung',
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      borderSide: BorderSide.none),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.grey, width: 0),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                                onChanged: (value) {
                                  TextSelection previousSelection = _leistungController.selection;
                                  _leistungController.text = value;
                                  _leistungController.selection = previousSelection;
                                  setState(() {
                                    _newService =
                                        _newService.copyWith(name: _leistungController.text);
                                  });
                                }),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width > 1000
                            ? 300
                            : MediaQuery.of(context).size.width / 10 * 3.5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Preis/std', style: TextStyle(fontWeight: FontWeight.bold)),
                            TextFormField(
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(
                                    r'^\d*[\.\,]?\d{0,2}',
                                  ),
                                ),
                              ],
                              controller: _preisController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: const Color.fromARGB(211, 245, 241, 241),
                                hintText: 'Preis/std',
                                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: BorderSide.none),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.grey, width: 0),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              onChanged: (value) {
                                if (value.contains(',')) {
                                  final list = value.split('');
                                  String newValue = '';
                                  for (var e in list) {
                                    if (e == ',') {
                                      newValue += '.';
                                    } else {
                                      newValue += e;
                                    }
                                  }
                                  value = newValue;
                                }
                                TextSelection previousSelection = _preisController.selection;
                                _preisController.text = value;
                                _preisController.selection = previousSelection;
                                setState(() {
                                  _newService = _newService.copyWith(
                                      hourlyRate: double.tryParse(_preisController.text) ?? 0);
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 12),
                        child: SymmetricButton(
                          text: 'Verwerfen',
                          textStyle: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: AppColor.kPrimaryButtonColor),
                          color: AppColor.kWhite,
                          onPressed: () {
                            _leistungController.clear();
                            _preisController.clear();
                            widget.onReject();
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 12.0),
                        child: Consumer(
                          builder: (context, ref, child) => SymmetricButton(
                            text: 'Speichern',
                            textStyle: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(color: AppColor.kWhite),
                            onPressed: () {
                              final leistung = _leistungController.text;
                              final preis = _preisController.text;
                              if (leistung.isNotEmpty && preis.isNotEmpty) {
                                ref
                                    .read(serviceVMProvider.notifier)
                                    .createService(_newService)
                                    .then((e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Center(
                                          child: Text(e
                                              ? 'Neue Leistung wurde erstellt'
                                              : 'Leider ist etwas schief gegagen')),
                                    ),
                                  );
                                });
                              } else {
                                showDialog(
                                  barrierColor: const Color.fromARGB(20, 0, 0, 0),
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    backgroundColor: AppColor.kWhite,
                                    title: const Text('Fehlende Informationen'),
                                    content: const Text('Bitte füllen Sie alle Felder aus.'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
