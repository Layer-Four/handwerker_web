import 'package:flutter/material.dart';

import '../../../../constants/themes/app_color.dart';
import '../../../../constants/utilitis/utilitis.dart';
import '../../../../models/project_models/customer_projekt_model/custom_project.dart';
import '../../../shared_widgets/symetric_button_widget.dart';

class AddNewConsumable extends StatefulWidget {
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final CustomeProject? project;

  const AddNewConsumable({
    super.key,
    required this.onSave,
    required this.onCancel,
    this.project,
  });

  @override
  State<AddNewConsumable> createState() => _AddNewConsumableState();
}

class _AddNewConsumableState extends State<AddNewConsumable> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _secondNameController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _housenumberController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _postNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _customerNumberController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.project != null) {
      // Assuming 'customer' is a field in CustomeProject
      _firstNameController.text = widget.project!.customer;
    }
  }

  //dispose of controllers
  @override
  void dispose() {
    _firstNameController.dispose();
    _secondNameController.dispose();
    _streetController.dispose();
    _housenumberController.dispose();
    _cityController.dispose();
    _postNumberController.dispose();
    _emailController.dispose();
    _customerNumberController.dispose();
    _telephoneController.dispose();
    _contactController.dispose();
    super.dispose(); // Always call super.dispose() last
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
                              hintText: 'Vorname',
                              controller: _firstNameController,
                              context: context,
                            ),
                            const SizedBox(height: 5),
                            buildTextField(
                              hintText: 'Nachname',
                              controller: _secondNameController,
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
                              child: Text('Addresse', style: TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  //    height: 100,
                                  width: 300,
                                  child: buildTextField(
                                    hintText: 'Straße',
                                    controller: _streetController,
                                    context: context,
                                  ),
                                ),
                                const SizedBox(width: 2),
                                SizedBox(
                                  //      height: 100,
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
                                  //    height: 100,
                                  width: 300,
                                  child: buildTextField(
                                    hintText: 'Ort',
                                    controller: _cityController,
                                    context: context,
                                  ),
                                ),
                                const SizedBox(width: 2),
                                SizedBox(
                                  //    height: 100,
                                  width: 100,
                                  child: buildTextField(
                                    hintText: 'plz',
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
                              controller: _customerNumberController,
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
                              controller: _telephoneController,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SymmetricButton(
                          color: const Color.fromARGB(255, 241, 241, 241),
                          text: 'Verwerfen',
                          textStyle: TextStyle(color: AppColor.kPrimaryButtonColor),
                          onPressed: () {
                            widget.onCancel();
                            // dispose();
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SymmetricButton(
                          text: 'Speichern',
                          onPressed: widget.onSave,
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
}

Widget buildTextField({
  required String hintText,
  required TextEditingController controller,
  required BuildContext context,
}) =>
    SizedBox(
      // height: 100,
      //width: 200,
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: TextField(
          controller: controller,
          decoration: Utilitis.textFieldDecoration(hintText),
        ),
      ),
    );
