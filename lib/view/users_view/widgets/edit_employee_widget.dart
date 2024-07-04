import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../constants/themes/app_color.dart';
import '../../../constants/utilitis/utilitis.dart';
import '../../../models/users_models/user_role/user_role.dart';
import '../../../provider/user_provider/user_administration/user_administration._provider.dart';
import '../../shared_widgets/symetric_button_widget.dart';

class AddNewEmployee extends ConsumerStatefulWidget {
  final double overflowWidth;
  final List<UserRole> roles;

  const AddNewEmployee(this.roles, {super.key, this.overflowWidth = 850});

  @override
  ConsumerState<AddNewEmployee> createState() => _AddNewEmployeeState();
}

class _AddNewEmployeeState extends ConsumerState<AddNewEmployee> {
  final RegExp _specialSign = RegExp(r'[äöüß !"#$%&()*+,./:;<=>?@[\]^_`{|}~]');
  bool _isSnackbarOpen = false;
  UserRole? _selectedRole;
  bool _createdUser = false;
  final List<UserRole> _roles = [];
  Map<String, dynamic>? _newUser;

  final int _snackBarDuration = 7;
  final TextEditingController _nameController = TextEditingController();
  // final TextEditingController _secondNameController = TextEditingController();
  // final TextEditingController _streetController = TextEditingController();
  // final TextEditingController _housenumberController = TextEditingController();
  // final TextEditingController _cityController = TextEditingController();
  // final TextEditingController _postNumberController = TextEditingController();
  // final TextEditingController _emailController = TextEditingController();
  // final TextEditingController _customerNumberController = TextEditingController();
  // final TextEditingController _telephoneController = TextEditingController();
  // final TextEditingController _contactController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _roles.addAll(widget.roles);
    _selectedRole = _roles.first;
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
            child: !_createdUser
                ? _createUserField(overflowWith, constrains)
                : _showUserCredential(overflowWith, constrains),
          ),
        ),
      ),
    );
  }

  Widget _showUserCredential(double overflowWith, BoxConstraints constrains) => _createdUser &&
          _newUser == null
      ? const Text('Erstelle Eintrag')
      : Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width:
                  MediaQuery.of(context).size.width >= overflowWith ? 355 : constrains.maxWidth / 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Neuer Nutzer wurde angelegt',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: AppColor.kPrimaryButtonColor,
                          fontWeight: FontWeight.bold,
                        ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Nutzername: ',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontWeight: FontWeight.bold)),
                      ),
                      Text('${_newUser!['userName']}',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Einmal Passwort: ',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontWeight: FontWeight.bold)),
                      ),
                      Text('${_newUser!['password']}',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.width >= overflowWith ? 32.0 : 12,
                    ),
                    child: SymmetricButton(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width >= overflowWith ? 50 : 15,
                          vertical: MediaQuery.of(context).size.width >= overflowWith ? 6 : 3),
                      textStyle: MediaQuery.of(context).size.width >= overflowWith
                          ? Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(color: AppColor.kWhite)
                          : Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: AppColor.kWhite),
                      text: 'Drucken',
                      onPressed: () async => Utilitis.writePDFAndDownload(_newUser!),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: QrImageView(
                data: '${_newUser!['userName']} ${_newUser!['password']}',
                version: QrVersions.auto,
                size: MediaQuery.of(context).size.width >= overflowWith
                    ? 250
                    : ((constrains.maxWidth / 10) * 3.4),
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
            ),
          ],
        );

  Column _createUserField(double overflowWith, BoxConstraints constrains) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Neuer Nutzer',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: AppColor.kGrey),
          ),
          Row(
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        child: Text(
                          'Name',
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      buildTextField(),
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        child: Text(
                          'Role',
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      _roles.isNotEmpty ? buildDropdown() : const Text('Lade Nutzerrolle'),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
                child: SizedBox(
                  width: 140,
                  child: SymmetricButton(
                    text: 'Speichern',
                    onPressed: () {
                      if (_selectedRole != null &&
                          _nameController.text.isNotEmpty &&
                          !_nameController.text.contains(_specialSign)) {
                        ref
                            .read(userAdministrationProvider.notifier)
                            .createUser(role: _selectedRole!, name: _nameController.text)
                            .then((value) {
                          if (value.keys.contains('error')) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Center(
                                  child: Text(
                                      'Nutzer konnte nicht erstellt werden.\nNutzer mit diesem Namen exisiert bereits'),
                                ),
                              ),
                            );
                            return;
                          }
                          setState(() {
                            _newUser = value;
                            _createdUser = _newUser != null;
                          });
                          return;
                        });
                      } else {
                        if (!_isSnackbarOpen) {
                          setState(() => _isSnackbarOpen = true);
                          Future.delayed(Duration(seconds: _snackBarDuration))
                              .then((_) => setState(() => _isSnackbarOpen = false));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              duration: Duration(seconds: _snackBarDuration),
                              content: const Center(
                                child: Text(
                                    'Bitte vermeinden sie Umlaute, Sonderzeichen und Leerzeichen'),
                              ),
                            ),
                          );
                        }
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ],
      );

  Widget buildTextField() => SizedBox(
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: TextField(
            controller: _nameController,
            decoration: InputDecoration(
              hintText: 'Jonathan Mueller',
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: AppColor.kTextfieldBorder),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 5,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: AppColor.kTextfieldBorder,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColor.kTextfieldBorder),
              ),
            ),
            onChanged: (value) {
              setState(() {
                if (value.contains(_specialSign)) {
                  if (!_isSnackbarOpen) {
                    setState(() => _isSnackbarOpen = true);
                    Future.delayed(Duration(seconds: _snackBarDuration))
                        .then((_) => setState(() => _isSnackbarOpen = false));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: Duration(seconds: _snackBarDuration),
                        content: const Center(
                          child:
                              Text('Bitte vermeinden sie Umlaute, Sonderzeichen und Leerzeichen'),
                        ),
                      ),
                    );
                  }
                  _nameController.text =
                      _nameController.text.substring(0, _nameController.text.length - 1);
                  _nameController.text.toLowerCase();
                  return;
                }
                TextSelection previousSelection = _nameController.selection;
                _nameController.text = value;
                _nameController.selection = previousSelection;
                _nameController.text.toLowerCase();
              });
            },
          ),
        ),
      );

// TODO:We need a FormField or is a normal DropDown suiteable
  Widget buildDropdown() => DropdownButtonFormField(
        isExpanded: true,
        value: _selectedRole,
        decoration: InputDecoration(
          hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: AppColor.kTextfieldBorder,
              ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 5,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: AppColor.kTextfieldBorder,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColor.kTextfieldBorder),
          ),
          filled: true,
          fillColor: Colors.grey[100],
        ),
        onChanged: (e) => setState(() => _selectedRole = e!),
        items: _roles
            .map((value) => DropdownMenuItem(
                  value: value,
                  child: Text(value.name),
                ))
            .toList(),
      );
}
