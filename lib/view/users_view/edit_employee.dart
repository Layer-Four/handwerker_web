import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../constants/themes/app_color.dart';
import '../../models/users_models/user_role/user_role.dart';
import '../../provider/user_provider/user_provider.dart';
import '../customer_project_view/custom_project.dart';
import '../shared_view_widgets/symetric_button_widget.dart';

class AddNewEmployee extends ConsumerStatefulWidget {
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final CustomeProject? project;
  final double overflowWidth;

  const AddNewEmployee({
    super.key,
    required this.onSave,
    required this.onCancel,
    this.overflowWidth = 850,
    this.project,
  });

  @override
  ConsumerState<AddNewEmployee> createState() => _AddNewEmployeeState();
}

class _AddNewEmployeeState extends ConsumerState<AddNewEmployee> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _secondNameController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _housenumberController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _postNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _customerNumberController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  UserRole? _selectedRole;
  bool createdUser = false;
  final List<UserRole> _roles = [];

  @override
  void initState() {
    super.initState();
    if (widget.project != null) {
      _nameController.text =
          widget.project!.customer; // Assuming 'customer' is a field in CustomeProject
    }
    initUserRoles();
  }

  void initUserRoles() {
    ref.read(userProvider.notifier).loadUserRoles().then((e) => setState(() {
          _roles.addAll(e);
          _selectedRole = _roles.first;
        }));
  }

  //dispose of controllers
  @override
  void dispose() {
    _nameController.dispose();
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
  Widget build(BuildContext context) {
    final overflowWith = widget.overflowWidth;
    return LayoutBuilder(
        builder: (context, constrains) => Container(
              width: constrains.maxWidth >= overflowWith ? 800 : null,
              padding: const EdgeInsets.all(10.0),
              child: Card(
                elevation: 9,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: !createdUser
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Neuer Nutzer',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(color: AppColor.kGrey),
                            ),
                            Row(
                              // mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width >= overflowWith
                                      ? 250
                                      : ((constrains.maxWidth / 10) * 2.5),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Padding(
                                          padding:
                                              EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                          child: Text('Name',
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold, fontSize: 18)),
                                        ),
                                        buildTextField(
                                          hintText: 'Jonathan Müller',
                                          controller: _nameController,
                                          onChanged: (value) {
                                            setState(() {
                                              TextSelection previousSelection =
                                                  _nameController.selection;
                                              _nameController.text = value;
                                              _nameController.selection = previousSelection;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width > overflowWith
                                      ? 250
                                      : constrains.maxWidth / 10 * 2.5,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Padding(
                                          padding:
                                              EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                          child: Text('Role',
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold, fontSize: 18)),
                                        ),
                                        _roles.isNotEmpty
                                            ? buildDropdown(
                                                options: _roles,
                                                // selectedValue: roleOption,
                                                onChanged: (UserRole? value) {
                                                  setState(() {
                                                    if (value != null) _selectedRole = value;
                                                  });
                                                },
                                              )
                                            : const CircularProgressIndicator(),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: 140,
                                    child: SymmetricButton(
                                      text: 'Speichern',
                                      style: const TextStyle(color: Colors.white, fontSize: 18),
                                      onPressed: () {
                                        setState(() {
                                          if (_selectedRole != null) {
                                            ref.read(userProvider.notifier).createUser(
                                                role: _selectedRole!, name: _nameController.text);
                                            createdUser = !createdUser;
                                          }
                                        });
                                      }, //widget.onSave
                                    ),
                                  ),
                                )
                              ],
                            ),
                            // Expanded(
                            //   // flex: 2,
                            //   child: Column(
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     children: [
                            //       const Padding(
                            //         padding: EdgeInsets.fromLTRB(8, 4, 4, 20),
                            //         child: Text('Rolle',
                            //             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                            //       ),
                            //       SizedBox(
                            //         //    height: 100,
                            //         //  width: 300,
                            //         child: buildDropdown(
                            //           options: ['Admin', 'Mitarbeiter'],
                            //           // selectedValue: roleOption,
                            //           onChanged: (value) {
                            //             setState(() {
                            //               roleOption = value;
                            //             });
                            //           },
                            //           context: context,
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
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
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Neuer Nutzer wurde angelegt',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.kPrimaryButtonColor,
                                        fontSize: 22)),
                                const SizedBox(height: 30),
                                Row(
                                  children: [
                                    const Text('Nutzername: ',
                                        style:
                                            TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                                    const Spacer(),
                                    Text(_nameController.text,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold, fontSize: 22)),
                                  ],
                                ),
                                const SizedBox(height: 30),
                                const Row(
                                  children: [
                                    Text('Einmal Passwort: ',
                                        style:
                                            TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                                    Spacer(),
                                    Text('Xcy24KjIq0abkAd',
                                        style:
                                            TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                                  ],
                                ),
                                const SizedBox(height: 30),
                                SizedBox(
                                  height: 100,
                                  width: 300,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 16, 16, 16),
                                    child: SymmetricButton(
                                      color: AppColor.kPrimaryButtonColor,
                                      text: 'Drucken',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22,
                                          color: Colors.white),
                                      onPressed: null,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 50),
                            QrImageView(
                              data:
                                  'Nutzername: ${_nameController.text}\nEinmal Passwort: Xcy24KjIq0abkAd',
                              version: QrVersions.auto,
                              //  size: 200.0,
                              gapless: false,
                              embeddedImageStyle: const QrEmbeddedImageStyle(
                                size: Size(80, 80),
                              ),
                              errorStateBuilder: (cxt, err) => const Center(
                                child: Text(
                                  'Uh oh! Something went wrong...',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ));
  }

  Widget buildTextField({
    required String hintText,
    required TextEditingController controller,
    final Function(String)? onChanged,
  }) =>
      SizedBox(
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
            onChanged: onChanged,
          ),
        ),
      );

  Widget buildDropdown({
    required List<UserRole> options,
    Function(UserRole?)? onChanged,
  }) =>
      DropdownButtonFormField(
        isExpanded: true,
        value: options.first,
        decoration: InputDecoration(
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
            .map((value) => DropdownMenuItem(
                  value: value,
                  child: Text(value.name),
                ))
            .toList(),
      );
}
