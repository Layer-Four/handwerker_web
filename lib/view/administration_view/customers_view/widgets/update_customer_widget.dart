import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../constants/themes/app_color.dart';
import '../../../../constants/utilitis/utilitis.dart';
import '../../../../models/customer_models/customer_create_model/create_customer_model.dart';
import '../../../../models/customer_models/customer_credential/customer_credential.dart';
import '../../../../models/customer_models/customer_overview_dm/customer_overvew_dm.dart';
import '../../../../provider/customer_provider/customer_provider.dart';
import '../../../shared_widgets/symetric_button_widget.dart';

class UpdateCustomerWidget extends StatefulWidget {
  final CustomerOvervewDM customer;
  final ValueChanged<CustomerOvervewDM>? onSave;
  final VoidCallback? onCancel;

  const UpdateCustomerWidget({
    super.key,
    required this.customer,
    this.onSave,
    this.onCancel,
  });

  @override
  State<UpdateCustomerWidget> createState() => _UpdateCustomerWidgetState();
}

class _UpdateCustomerWidgetState extends State<UpdateCustomerWidget> {
  bool _isSnackbarShowed = false;

  late final TextEditingController _nameController = TextEditingController();
  late final TextEditingController _companyNameController = TextEditingController();
  late final TextEditingController _streetController = TextEditingController();
  late final TextEditingController _housenumberController = TextEditingController();
  late final TextEditingController _cityController = TextEditingController();
  late final TextEditingController _postNumberController = TextEditingController();
  late final TextEditingController _emailController = TextEditingController();
  late final TextEditingController _customerNumberController = TextEditingController();
  late final TextEditingController _telephoneController = TextEditingController();
  late final TextEditingController _contactController = TextEditingController();

  late final CustomerOvervewDM _initialCustomer;

  @override
  void initState() {
    super.initState();
    _initialCustomer = widget.customer;
    _companyNameController.text = _initialCustomer.customerCredentials.companyName ?? '';
    _nameController.text = _initialCustomer.customerCredentials.contactName;
    _streetController.text = _initialCustomer.customerCredentials.customerStreet ?? '';
    _housenumberController.text = _initialCustomer.customerCredentials.customerStreetNr ?? '';
    _cityController.text = _initialCustomer.customerCredentials.customerCity ?? '';
    _postNumberController.text = _initialCustomer.customerCredentials.customerZipcode ?? '';
    _emailController.text = _initialCustomer.customerCredentials.customerEmail ?? '';
    _customerNumberController.text = _initialCustomer.customerCredentials.customerNumber ?? '';
    _telephoneController.text = _initialCustomer.customerCredentials.customerPhone ?? '';
  }

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
  Widget build(BuildContext context) => Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width > 900 ? 900 : MediaQuery.of(context).size.width,
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
                            child: Text('Kontaktinformation',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          buildTextField(
                            hintText: 'Kundenname',
                            controller: _companyNameController,
                            context: context,
                          ),
                          const SizedBox(height: 5),
                          buildTextField(
                            hintText: 'Kontaktperson',
                            controller: _nameController,
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
                          const SizedBox(height: 17),
                          const Padding(
                            padding: EdgeInsets.all(4),
                            child: Text(''),
                          ),
                          buildTextField(
                            hintText: 'Kundennummer',
                            controller: _customerNumberController,
                            context: context,
                          ),
                          const SizedBox(height: 4),
                          Consumer(
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
                                    onPressed: widget.onCancel,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: SymmetricButton(
                                    text: 'Speichern',
                                    onPressed: () async {
                                      if (_streetController.text.isEmpty &&
                                          _cityController.text.isEmpty &&
                                          _companyNameController.text.isEmpty &&
                                          _nameController.text.isEmpty &&
                                          _contactController.text.isEmpty &&
                                          _customerNumberController.text.isEmpty &&
                                          _telephoneController.text.isEmpty &&
                                          _postNumberController.text.isEmpty) {
                                        _showSnackBar('Bitte füllen Sie alle Felder aus.');
                                        return;
                                      }

                                      final x = CreateCustomerDM(
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

                                      try {
                                        final success = await ref
                                            .read(customerProvider.notifier)
                                            .updateCustomer(x, _initialCustomer.customerID!);
                                        if (success) {
                                          if (widget.onSave != null) {
                                            // Create updated CustomerOvervewDM
                                            final updatedCustomer = CustomerOvervewDM(
                                              customerID: _initialCustomer.customerID,
                                              customerCredentials: CustomerCredentialDM(
                                                companyName: _companyNameController.text,
                                                contactName: _nameController.text,
                                                customerStreet: _streetController.text,
                                                customerStreetNr: _housenumberController.text,
                                                customerCity: _cityController.text,
                                                customerZipcode: _postNumberController.text,
                                                customerEmail: _emailController.text,
                                                customerNumber: _customerNumberController.text,
                                                customerPhone: _telephoneController.text,
                                              ),
                                              numOfProjects: _initialCustomer.numOfProjects,
                                              totalCostMaterial: _initialCustomer.totalCostMaterial,
                                              totalTimeTracked: _initialCustomer.totalTimeTracked,
                                              turnover: _initialCustomer.turnover,
                                            );

                                            widget.onSave!(updatedCustomer);
                                          }
                                        } else {
                                          _showSnackBar('Speichern fehlgeschlagen');
                                        }
                                      } catch (e) {
                                        _showSnackBar('Ein Fehler ist aufgetreten');
                                      }
                                    },
                                  ),
                                ),
                              ],
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
