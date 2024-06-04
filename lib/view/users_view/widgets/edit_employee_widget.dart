import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../constants/themes/app_color.dart';
import '../../../constants/utilitis/utilitis.dart';
import '../../../models/users_models/user_role/user_role.dart';
import '../../../provider/user_provider/user_administration/user_administration._provider.dart';
import '../../shared_view_widgets/symetric_button_widget.dart';

class AddNewEmployee extends ConsumerStatefulWidget {
  final VoidCallback? onSave;
  final VoidCallback? onCancel;
  final double overflowWidth;

  const AddNewEmployee({
    super.key,
    this.onSave,
    required this.onCancel,
    this.overflowWidth = 850,
  });

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

    initUserRoles();
  }

  void initUserRoles() {
    ref.read(userAdministrationProvider.notifier).loadUserRoles().then((e) => setState(() {
          _roles.addAll(e);
          _selectedRole = _roles.first;
        }));
  }

  //dispose of controllers
  // @override
  // void dispose() {
  //   _nameController.dispose();
  //   _secondNameController.dispose();
  //   _streetController.dispose();
  //   _housenumberController.dispose();
  //   _cityController.dispose();
  //   _postNumberController.dispose();
  //   _emailController.dispose();
  //   _customerNumberController.dispose();
  //   _telephoneController.dispose();
  //   _contactController.dispose();
  //   super.dispose(); // Always call super.dispose() last
  // }

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
                      style: MediaQuery.of(context).size.width >= overflowWith
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
                // data: 'Nutzername: ${_nameController.text}\nEinmal Passwort: Xcy24KjIq0abkAd',
                data: '${_newUser!['userName']} ${_newUser!['password']}',
                version: QrVersions.auto,
                size: MediaQuery.of(context).size.width >= overflowWith
                    ? 250
                    : ((constrains.maxWidth / 10) * 3.4),
                // gapless: false,
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
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        child: Text('Name',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      ),
                      buildTextField(
                        hintText: 'Jonathan Mueller',
                        controller: _nameController,
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
                                    content: const Text(
                                        'Bitte vermeinden sie Umlaute, Sonderzeichen und Leerzeichen'),
                                  ),
                                );
                              }
                              _nameController.text = _nameController.text
                                  .substring(0, _nameController.text.length - 1);
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
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        child: Text('Role',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
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
                          : const Text('Lade Nutzerrolle'),
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
                                content: Text(
                                    'Nutzer konnte nicht erstellt werden.\nNutzer mit diesem Namen exisiert bereits'),
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
                              content: const Text(
                                  'Bitte vermeinden sie Umlaute, Sonderzeichen und Leerzeichen'),
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
