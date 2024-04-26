import 'package:flutter/material.dart';

import '../customer_project_view/custom_project.dart';
import '../shared_view_widgets/symetric_button_widget.dart';
import 'package:qr_flutter/qr_flutter.dart';

class AddNewEmployee extends StatefulWidget {
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final CustomeProject? project;

  AddNewEmployee({super.key, required this.onSave, required this.onCancel, this.project});

  @override
  State<AddNewEmployee> createState() => _AddNewEmployeeState();
}

class _AddNewEmployeeState extends State<AddNewEmployee> {
  TextEditingController _NameController = TextEditingController();
  TextEditingController _secondNameController = TextEditingController();
  TextEditingController _streetController = TextEditingController();
  TextEditingController _housenumberController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _postNumberController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _customerNumberController = TextEditingController();
  TextEditingController _telephoneController = TextEditingController();
  TextEditingController _contactController = TextEditingController();
  String? roleOption;
  bool createdUser = false;

  @override
  void initState() {
    super.initState();
    if (widget.project != null) {
      _NameController.text = widget.project!.customer; // Assuming 'customer' is a field in CustomeProject
    }
  }

  //dispose of controllers
  @override
  void dispose() {
    _NameController.dispose();
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 8.0),
          child: Card(
            elevation: 9,
            child: Container(
              color: const Color.fromARGB(255, 255, 255, 255),
              height: 400,
              width: double.infinity,
              padding: const EdgeInsets.all(30.0),
              child: !createdUser
                  ? Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        //  const SizedBox(height: 20),
                        const Expanded(
                          flex: 1,
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(20, 4, 4, 4),
                              child: Text(
                                'Neuer Nutzer',
                                style: TextStyle(color: Colors.grey, fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(width: 50),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.fromLTRB(8, 4, 4, 20),
                                      child: Text('Name', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                                    ),
                                    buildTextField(
                                      hintText: 'Jonathan Müller',
                                      controller: _NameController,
                                      context: context,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 30),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.fromLTRB(8, 4, 4, 20),
                                      child: Text('Rolle', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                                    ),
                                    SizedBox(
                                      //    height: 100,
                                      //  width: 300,
                                      child: buildDropdown(
                                        options: ['Admin', 'Mitarbeiter'],
                                        // selectedValue: roleOption,
                                        onChanged: (value) {
                                          setState(() {
                                            roleOption = value;
                                          });
                                        },
                                        context: context,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 30),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.fromLTRB(8, 4, 4, 20),
                                      child: Text('', style: TextStyle(fontWeight: FontWeight.bold)),
                                    ),
                                    SizedBox(
                                      //    height: 100,
                                      width: 160,
                                      child: Padding(
                                        padding: const EdgeInsets.all(0.0),
                                        child: SymmetricButton(
                                          color: Colors.orange,
                                          text: 'Speichern',
                                          style: const TextStyle(color: Colors.white, fontSize: 18),
                                          onPressed: () {
                                            setState(() {
                                              createdUser = !createdUser;
                                            });
                                          }, //widget.onSave
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        /*                Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SymmetricButton(
                          color: const Color.fromARGB(255, 241, 241, 241),
                          text: 'Verwerfen',
                          style: const TextStyle(color: Colors.orange),
                          onPressed: () {
                            widget.onCancel();
                            //Dispose of controllers
                            //     dispose();
                          }, //onCancel
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SymmetricButton(
                          color: Colors.orange,
                          text: 'Speichern',
                          onPressed: widget.onSave,
                        ),
                      ),
                    ],
                  ),*/
                      ],
                    )
                  : Row(
                      children: [
                        const SizedBox(width: 20),
                        Expanded(
                          flex: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Neuer Nutzer wurde angelegt',
                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange, fontSize: 22)),
                              const SizedBox(height: 30),
                              Row(
                                children: [
                                  const Text('Nutzername: ',
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                                  const Spacer(),
                                  Text(_NameController.text,
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                                ],
                              ),
                              const SizedBox(height: 30),
                              const Row(
                                children: [
                                  Text('Einmal Passwort: ',
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                                  Spacer(),
                                  Text('Xcy24KjIq0abkAd', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                                ],
                              ),
                              const SizedBox(height: 30),
                              const SizedBox(
                                height: 100,
                                width: 300,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(0, 16, 16, 16),
                                  child: SymmetricButton(
                                    color: Colors.orange,
                                    text: 'Drucken',
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white),
                                    onPressed: null,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 50),
                        Expanded(
                          flex: 1,
                          child: QrImageView(
                            data: 'Nutzername: ${_NameController.text}\nEinmal Passwort: Xcy24KjIq0abkAd',
                            version: QrVersions.auto,
                            //  size: 200.0,
                            gapless: false,
                            embeddedImageStyle: const QrEmbeddedImageStyle(
                              size: Size(80, 80),
                            ),
                            errorStateBuilder: (cxt, err) => Container(
                              child: const Center(
                                child: Text(
                                  "Uh oh! Something went wrong...",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
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
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: const Color.fromARGB(255, 220, 217, 217),
                ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 5,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 220, 217, 217),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color.fromARGB(255, 220, 217, 217)),
            ),
          ),
        ),
      ),
    );

Widget buildDropdown({
  required List<String> options,
  String? selectedValue,
  required ValueChanged<String?> onChanged,
  required BuildContext context,
}) =>
    Container(
      //  width: 300,
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: DropdownButtonFormField<String>(
          value: selectedValue,
          decoration: InputDecoration(
            hintText: 'Select option',
            hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: const Color.fromARGB(255, 220, 217, 217),
                ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 5,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 220, 217, 217),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color.fromARGB(255, 220, 217, 217)),
            ),
            filled: true,
            fillColor: Colors.grey[100],
          ),
          onChanged: onChanged,
          items: options
              .map<DropdownMenuItem<String>>((String value) => DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  ))
              .toList(),
        ),
      ),
    );
