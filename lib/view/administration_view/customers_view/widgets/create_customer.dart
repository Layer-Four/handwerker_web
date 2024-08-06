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
  // late final TextEditingController _nameController = TextEditingController();
  late final TextEditingController _companyNameController = TextEditingController();
  late final TextEditingController _streetController = TextEditingController();
  late final TextEditingController _housenumberController = TextEditingController();
  late final TextEditingController _cityController = TextEditingController();
  late final TextEditingController _postNumberController = TextEditingController();
  late final TextEditingController _emailController = TextEditingController();
  late final TextEditingController _customerNumberController = TextEditingController();
  late final TextEditingController _telephoneController = TextEditingController();
  late final TextEditingController _contactController = TextEditingController();

  late CreateCustomerDM _createCustomer;

  @override
  void initState() {
    super.initState();
    _createCustomer = const CreateCustomerDM();
  }

  @override
  void dispose() {
    // _nameController.dispose();
    _companyNameController.dispose();
    _streetController.dispose();
    _housenumberController.dispose();
    _cityController.dispose();
    _postNumberController.dispose();
    _emailController.dispose();
    _customerNumberController.dispose();
    _telephoneController.dispose();
    _contactController.dispose();
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
                              controller: _companyNameController,
                              context: context,
                            ),
                            const SizedBox(height: 5),
                            buildTextField(
                              hintText: 'Kontaktperson',
                              controller: _contactController,
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
                                    controller: _housenumberController,
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
                                    controller: _postNumberController,
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
                              controller: _telephoneController,
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
                                            // Log the content of each field
                                            print('Street: ${_streetController.text}');
                                            print('City: ${_cityController.text}');
                                            print('Company Name: ${_companyNameController.text}');
                                            print('Contact: ${_contactController.text}');
                                            print('Customer Number: ${_customerNumberController.text}');
                                            print('Telephone: ${_telephoneController.text}');
                                            print('Post Number: ${_postNumberController.text}');
                                            print('House Number: ${_housenumberController.text}');
                                            print('Email: ${_emailController.text}');

                                            // Check each field individually
                                            if (_streetController.text.isEmpty) {
                                              _showSnackBar('Bitte füllen Sie das Straße-Feld aus.');
                                              return;
                                            }
                                            if (_cityController.text.isEmpty) {
                                              _showSnackBar('Bitte füllen Sie das Ort-Feld aus.');
                                              return;
                                            }
                                            if (_companyNameController.text.isEmpty) {
                                              _showSnackBar('Bitte füllen Sie das Kundenname-Feld aus.');
                                              return;
                                            }
                                            if (_contactController.text.isEmpty) {
                                              _showSnackBar('Bitte füllen Sie das Kontaktperson-Feld aus.');
                                              return;
                                            }
                                            if (_customerNumberController.text.isEmpty) {
                                              _showSnackBar('Bitte füllen Sie das Kundennummer-Feld aus.');
                                              return;
                                            }
                                            if (_telephoneController.text.isEmpty) {
                                              _showSnackBar('Bitte füllen Sie das Telefon-Feld aus.');
                                              return;
                                            }
                                            if (_postNumberController.text.isEmpty) {
                                              _showSnackBar('Bitte füllen Sie das PLZ-Feld aus.');
                                              return;
                                            }
                                            if (_housenumberController.text.isEmpty) {
                                              _showSnackBar('Bitte füllen Sie das Nr-Feld aus.');
                                              return;
                                            }
                                            if (_emailController.text.isEmpty) {
                                              _showSnackBar('Bitte füllen Sie das Email-Feld aus.');
                                              return;
                                            }

                                            // If we've made it this far, all fields are filled
                                            _createCustomer = _createCustomer.copyWith(
                                              city: _cityController.text,
                                              street: _streetController.text,
                                              companyName: _companyNameController.text,
                                              contactMail: _emailController.text,
                                              contactPhone: _telephoneController.text,
                                              streetNr: _housenumberController.text,
                                              zipcode: _postNumberController.text,
                                              contactName: _contactController.text,
                                              externalId: _customerNumberController.text,
                                            );

                                            ref
                                                .read(customerProvider.notifier)
                                                .createCustomer(_createCustomer)
                                                .then((success) {
                                              if (success) {
                                                _showSnackBar('Kunde erfolgreich hinzufügt');
                                                _companyNameController.clear();
                                                _cityController.clear();
                                                _contactController.clear();
                                                _emailController.clear();
                                                _customerNumberController.clear();
                                                _postNumberController.clear();
                                                _telephoneController.clear();
                                                _streetController.clear();
                                                _housenumberController.clear();
                                                if (widget.onSave != null) {
                                                  widget.onSave!();
                                                }
                                              } else {
                                                _showSnackBar('Speichern fehlgeschlagen');
                                              }
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
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
