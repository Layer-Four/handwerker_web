import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../constants/themes/app_color.dart';
import '../../../../constants/utilitis/utilitis.dart';
import '../../../../models/customer_models/customer_create_model/create_customer_model.dart';
import '../../../../provider/customer_provider/customer_provider.dart';
import '../../../shared_widgets/symetric_button_widget.dart';

class CreateCustomerWidget extends StatefulWidget {
  final VoidCallback? onSave;
  final VoidCallback onCancel;

  const CreateCustomerWidget({
    super.key,
    this.onSave,
    required this.onCancel,
  });

  @override
  State<CreateCustomerWidget> createState() => _CreateCustomerWidgetState();
}

class _CreateCustomerWidgetState extends State<CreateCustomerWidget> {
  bool _isSnackbarShowed = false;
  late final TextEditingController _companyrNameCtrl = TextEditingController();
  late final TextEditingController _streetController = TextEditingController();
  late final TextEditingController _streetNrController = TextEditingController();
  late final TextEditingController _cityController = TextEditingController();
  late final TextEditingController _zipController = TextEditingController();
  late final TextEditingController _emailController = TextEditingController();
  late final TextEditingController _customerNumberController = TextEditingController();
  late final TextEditingController _contactPhoneCtrl = TextEditingController();
  late final TextEditingController _contactNameCtrl = TextEditingController();

  late CreateCustomerDM _createCustomer;

  @override
  void initState() {
    super.initState();
    _createCustomer = const CreateCustomerDM();
  }

  @override
  void dispose() {
    _companyrNameCtrl.dispose();
    _streetController.dispose();
    _streetNrController.dispose();
    _cityController.dispose();
    _zipController.dispose();
    _emailController.dispose();
    _customerNumberController.dispose();
    _contactPhoneCtrl.dispose();
    _contactNameCtrl.dispose();
    super.dispose();
  }

  void _showSnackBar(String message) {
    if (_isSnackbarShowed) return;
    setState(() => _isSnackbarShowed = true);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(child: Text(message)),
      ),
    );
    Future.delayed(const Duration(seconds: 1)).then(
      (_) => setState(() => _isSnackbarShowed = false),
    );
  }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width > 1000 ? 900 : MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6.0),
          child: Card(
            elevation: 9,
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Flexible(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4),
                              child: Text(
                                'Kontaktinformation',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                            buildTextField(
                              hintText: 'Kundenname',
                              controller: _companyrNameCtrl,
                              context: context,
                            ),
                            const SizedBox(height: 5),
                            buildTextField(
                              hintText: 'Kontaktperson',
                              controller: _contactNameCtrl,
                              context: context,
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4),
                              child: Text(
                                'Adresse',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Row(
                              children: [
                                Flexible(
                                  flex: 3,
                                  child: buildTextField(
                                    hintText: 'Straße',
                                    controller: _streetController,
                                    context: context,
                                  ),
                                ),
                                const SizedBox(width: 2),
                                Flexible(
                                  flex: 1,
                                  child: buildTextField(
                                    hintText: 'Nr',
                                    controller: _streetNrController,
                                    context: context,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Flexible(
                                  flex: 3,
                                  child: buildTextField(
                                    hintText: 'Ort',
                                    controller: _cityController,
                                    context: context,
                                  ),
                                ),
                                const SizedBox(width: 2),
                                Flexible(
                                  flex: 1,
                                  child: buildTextField(
                                    hintText: 'PLZ',
                                    controller: _zipController,
                                    context: context,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Flexible(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4),
                              child: Text(
                                'Sonstiges',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                            buildTextField(
                              hintText: 'Email',
                              controller: _emailController,
                              context: context,
                            ),
                            const SizedBox(height: 10),
                            buildTextField(
                              hintText: 'Telefon',
                              controller: _contactPhoneCtrl,
                              context: context,
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            const Padding(
                              padding: EdgeInsets.all(4),
                              child: Text(''),
                            ),
                            buildTextField(
                              hintText: 'Kundennummer',
                              controller: _customerNumberController,
                              context: context,
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              child: Padding(
                                  padding: const EdgeInsets.only(left: 8, right: 8),
                                  child: Consumer(
                                    builder: (context, ref, _) => Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: SymmetricButton(
                                            text: 'Verwerfen',
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .labelMedium
                                                ?.copyWith(color: AppColor.kPrimaryButtonColor),
                                            color: AppColor.kWhite,
                                            onPressed: () {
                                              widget.onCancel();
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: SymmetricButton(
                                            text: 'Speichern',
                                            onPressed: () {
                                              if (_streetController.text.isEmpty &&
                                                  _cityController.text.isEmpty &&
                                                  _companyrNameCtrl.text.isEmpty &&
                                                  _contactNameCtrl.text.isEmpty &&
                                                  _customerNumberController.text.isEmpty &&
                                                  _contactPhoneCtrl.text.isEmpty &&
                                                  _zipController.text.isEmpty) {
                                                _showSnackBar('Bitte füllen Sie alle Felder aus.');
                                                return;
                                              } else {
                                                _createCustomer = _createCustomer.copyWith(
                                                  city: _cityController.text,
                                                  street: _streetController.text,
                                                  companyName: _companyrNameCtrl.text,
                                                  contactMail: _emailController.text,
                                                  contactPhone: _contactPhoneCtrl.text,
                                                  streetNr: _streetNrController.text,
                                                  zipcode: _zipController.text,
                                                  contactName: _contactNameCtrl.text,
                                                  externalId: _customerNumberController.text,
                                                );

                                                ref
                                                    .read(customerProvider.notifier)
                                                    .createCustomer(_createCustomer)
                                                    .then((success) {
                                                  if (success) {
                                                    _showSnackBar('Kunde erfolgreich hinzufügt');
                                                    _companyrNameCtrl.clear();
                                                    _cityController.clear();
                                                    _contactNameCtrl.clear();
                                                    _emailController.clear();
                                                    _customerNumberController.clear();
                                                    _zipController.clear();
                                                    _contactPhoneCtrl.clear();
                                                    _streetController.clear();
                                                    _streetNrController.clear();
                                                  } else {
                                                    _showSnackBar('Speichern fehlgeschlagen');
                                                  }
                                                });
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                  // TextField(
                                  //   decoration: InputDecoration(border: InputBorder.none),
                                  // ),
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  Widget buildTextField({
    required String hintText,
    required TextEditingController controller,
    required BuildContext context,
  }) =>
      SizedBox(
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: TextField(
            controller: controller,
            decoration: Utilitis.textFieldDecoration(hintText),
          ),
        ),
      );
}
