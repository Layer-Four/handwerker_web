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

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _housenumberController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _postNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _customerNumberController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();

  late CreateCustomerDM _createCustomer;

  @override
  void initState() {
    super.initState();
    _createCustomer = const CreateCustomerDM();
  }

  // Dispose of controllers
  @override
  void dispose() {
    _nameController.dispose();
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
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8.0),
          child: Card(
            elevation: 9,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(4),
                              child: Text('Name', style: TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            buildTextField(
                              hintText: 'Kundenname',
                              controller: _nameController,
                              context: context,
                            ),
                            const SizedBox(height: 5),
                            buildTextField(
                              hintText: 'Unternehmenname',
                              controller: _companyNameController,
                              context: context,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(4),
                              child: Text('Adresse', style: TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 300,
                                  child: buildTextField(
                                    hintText: 'Straße',
                                    controller: _streetController,
                                    context: context,
                                  ),
                                ),
                                const SizedBox(width: 2),
                                SizedBox(
                                  width: 100,
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
                                SizedBox(
                                  width: 300,
                                  child: buildTextField(
                                    hintText: 'Ort',
                                    controller: _cityController,
                                    context: context,
                                  ),
                                ),
                                const SizedBox(width: 2),
                                SizedBox(
                                  width: 100,
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
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(4),
                              child: Text(
                                'Sonstiges',
                                style: TextStyle(fontWeight: FontWeight.bold),
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
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                            buildTextField(
                              hintText: 'Kontaktperson',
                              controller: _contactController,
                              context: context,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Consumer(
                    builder: (context, ref, _) => Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: SymmetricButton(
                            text: 'Verwerfen',
                            textStyle:
                                Theme.of(context).textTheme.labelMedium?.copyWith(color: AppColor.kPrimaryButtonColor),
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
                                  _companyNameController.text.isEmpty &&
                                  _contactController.text.isEmpty &&
                                  _customerNumberController.text.isEmpty &&
                                  _telephoneController.text.isEmpty &&
                                  _postNumberController.text.isEmpty) {
                                _showSnackBar('Bitte füllen Sie alle Felder aus.');
                                return;
                              }

                              _createCustomer = _createCustomer.copyWith(
                                city: _cityController.text,
                                street: _streetController.text,
                                companyName: _companyNameController.text,
                                contactMail: _emailController.text,
                                contactPhone: _telephoneController.text,
                                streetNr: _housenumberController.text,
                                zipcode: _postNumberController.text,
                                contactName: _nameController.text,
                                externalId: _customerNumberController.text,
                              );

                              ref.read(customerProvider.notifier).createCustomer(_createCustomer).then((success) {
                                if (success) {
                                  _nameController.clear();
                                  _companyNameController.clear();
                                  _cityController.clear();
                                  _contactController.clear();
                                  _emailController.clear();
                                  _customerNumberController.clear();
                                  _postNumberController.clear();
                                  _telephoneController.clear();
                                  _streetController.clear();
                                  _housenumberController.clear();
                                } else {
                                  _showSnackBar('Speichern fehlgeschlagen');
                                }
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  )
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