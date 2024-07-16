import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../constants/themes/app_color.dart';
import '../../../../constants/utilitis/utilitis.dart';
import '../../../../models/service_models/service_vm/service_vm.dart';
import '../../../../provider/data_provider/service_provider/service_vm_provider.dart';
import '../../../shared_widgets/symetric_button_widget.dart';

class CreateServiceWidget extends ConsumerStatefulWidget {
  final Function onReject;

  const CreateServiceWidget({
    required this.onReject,
    super.key,
  });

  @override
  ConsumerState<CreateServiceWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends ConsumerState<CreateServiceWidget> {
  late final TextEditingController _leistungCtlr;
  late final TextEditingController _priceCtlr;
  ServiceVM _newService = const ServiceVM(name: '', hourlyRate: 0);
  bool _isSnackbarShowed = false;
  late final Duration _snackbarDuration = const Duration(seconds: 7);

  @override
  void initState() {
    _leistungCtlr = TextEditingController();
    _priceCtlr = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _leistungCtlr.dispose();
    _priceCtlr.dispose();
    super.dispose();
  }

  void _resetFields() {
    setState(() {
      _leistungCtlr.clear();
      _priceCtlr.clear();
      _newService = const ServiceVM(
        name: '',
        hourlyRate: 0,
      );
    });
  }

  void _showSnackBar(String message) {
    if (_isSnackbarShowed) return;
    setState(() => _isSnackbarShowed = true);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.black.withOpacity(0.7),
        duration: _snackbarDuration,
      ),
    );
    Future.delayed(_snackbarDuration).then(
      (_) => setState(() => _isSnackbarShowed = false),
    );
  }

  void _saveService(BuildContext context) {
    if (_leistungCtlr.text.isNotEmpty && _priceCtlr.text.isNotEmpty) {
      ref.read(serviceVMProvider.notifier).createService(_newService).then((e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Center(
              child: Text(e ? 'Neue Leistung wurde erstellt' : 'Leider ist etwas schief gegagen'),
            ),
          ),
        );
        if (e) {
          _resetFields(); // Reset fields if creation is successful
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Center(
            child: Text('Bitte füllen Sie alle Felder aus.'),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) => SizedBox(
        width: MediaQuery.of(context).size.width > 1000
            ? 800
            : MediaQuery.of(context).size.width / 10 * 8,
        child: Card(
          elevation: 6,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    'Neue Leistung anlegen',
                    style:
                        Theme.of(context).textTheme.headlineSmall?.copyWith(color: AppColor.kGrey),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Padding(padding: EdgeInsets.all(12)),
                    SizedBox(
                      width: MediaQuery.of(context).size.width > 1000
                          ? 300
                          : MediaQuery.of(context).size.width * 0.35,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12.0),
                              child: Text(
                                'Leistung',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                            TextField(
                              controller: _leistungCtlr,
                              decoration: Utilitis.textFieldDecoration('Leistung'),
                              onChanged: (value) {
                                TextSelection previousSelection = _leistungCtlr.selection;
                                _leistungCtlr.text = value;
                                _leistungCtlr.selection = previousSelection;
                                setState(() {
                                  _newService = _newService.copyWith(name: _leistungCtlr.text);
                                });
                              },
                              onSubmitted: (_) => _saveService(context),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      width: MediaQuery.of(context).size.width > 1000
                          ? 180
                          : MediaQuery.of(context).size.width * 0.35,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Text(
                              'Preis',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                          TextFormField(
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'^\d*[\.\,]?\d{0,2}'))
                            ],
                            keyboardType: TextInputType.number,
                            controller: _priceCtlr,
                            decoration: Utilitis.textFieldDecoration('Preis/€'),
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

                              if (double.parse(value) > 10000) {
                                _showSnackBar('Diese Zahl ist zu groß');
                                _priceCtlr.text = value.substring(0, value.length - 1);
                                return;
                              }

                              TextSelection previousSelection = _priceCtlr.selection;
                              _priceCtlr.text = value;
                              _priceCtlr.selection = previousSelection;
                              setState(() {
                                _newService = _newService.copyWith(
                                    hourlyRate: double.tryParse(_priceCtlr.text) ?? 0);
                              });
                            },
                            onFieldSubmitted: (_) => _saveService(context),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 12),
                        child: SymmetricButton(
                          text: 'Verwerfen',
                          textStyle: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(color: AppColor.kPrimaryButtonColor),
                          color: AppColor.kWhite,
                          onPressed: () {
                            _leistungCtlr.clear();
                            _priceCtlr.clear();
                            widget.onReject();
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 12.0),
                        child: SymmetricButton(
                          text: 'Speichern',
                          onPressed: () => _saveService(context),
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
