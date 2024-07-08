import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../constants/themes/app_color.dart';
import '../../provider/user_provider/user_provider.dart';
import '../../routes/app_routes.dart';

class SetNewPasswordView extends StatefulWidget {
  const SetNewPasswordView({super.key});

  @override
  State<SetNewPasswordView> createState() => _PasswordViewState();
}

class _PasswordViewState extends State<SetNewPasswordView> {
  bool isFocused = false;
  bool _isOldPasswordVisible = false;
  bool isVisable = true;
  bool isPasswordVisible = false;

  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final emailController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _oTPController = TextEditingController();
  final _newPwController = TextEditingController();
  final _newPwRepeatController = TextEditingController();
  TextEditingController passCon = TextEditingController();

  bool isPassword6Char = false;
  bool isPasswordHas1Number = false;
  bool hasUppercase = false;
  bool hasLowercase = false;
  bool hasSpecialCharacters = false;

  onPasswordChanged(String password) {
    isPassword6Char = false;
    isPasswordHas1Number = false;
    hasUppercase = false;
    hasLowercase = false;
    hasSpecialCharacters = false;
    setState(() {
      if (password.contains(RegExp(r'.{6,}'))) {
        isPassword6Char = true;
      }

      if (password.contains(RegExp(r'[0-9]'))) {
        isPasswordHas1Number = true;
      }

      if (password.contains(RegExp(r'[A-Z]'))) {
        hasUppercase = true;
      }

      if (password.contains(RegExp(r'[a-z]'))) {
        hasLowercase = true;
      }

      if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
        hasSpecialCharacters = true;
      }
    });
  }

  waitLoad() async {
    setState(() {
      isLoading = true;
    });

    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    _newPwController.dispose();
    _newPwRepeatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: const Color.fromARGB(255, 254, 254, 245), //* DeckWeiss David
        appBar: AppBar(
          toolbarHeight: 30.0,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 33, right: 33),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Center(
                child: SizedBox(
                  width: 350,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 60,
                      ),
                      SizedBox(
                        height: 50,
                        child: Image.asset('assets/images/img_techtool.png'),
                      ),
                      const SizedBox(
                        height: 90,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Passwort zurücksetzen',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Nutzername',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Focus(
                          onFocusChange: (hasFocus) {
                            setState(() {
                              isFocused = hasFocus;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            height: isFocused ? 44 : 40,
                            child: TextField(
                              controller: _userNameController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: AppColor.kPrimaryButtonColor,
                                    width: 2,
                                  ),
                                ),
                                filled: true,
                                fillColor: const Color.fromARGB(255, 231, 226, 226),
                              ).copyWith(
                                contentPadding: const EdgeInsets.all(12),
                                isDense: true,
                              ),
                              onChanged: (value) {
                                TextSelection previousSelection = _userNameController.selection;
                                _userNameController.text = value;
                                _userNameController.selection = previousSelection;
                              },
                            ),
                          )),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Altes Passwort',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Focus(
                          onFocusChange: (hasFocus) {
                            setState(() {
                              isFocused = hasFocus;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            height: isFocused ? 44 : 40,
                            child: TextField(
                              controller: _oTPController,
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: AppColor.kPrimaryButtonColor,
                                    width: 2,
                                  ),
                                ),
                                filled: true,
                                fillColor: const Color.fromARGB(255, 231, 226, 226),
                              ).copyWith(
                                contentPadding: const EdgeInsets.all(12),
                                isDense: true,
                              ),
                              onChanged: (value) {
                                TextSelection previousSelection = _oTPController.selection;
                                _oTPController.text = value;
                                _oTPController.selection = previousSelection;
                              },
                            ),
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      const SizedBox(
                        width: 350,
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            'Neues Passwort',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Focus(
                          onFocusChange: (hasFocus) {
                            setState(() {
                              isFocused = hasFocus;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            height: isFocused ? 44 : 40,
                            child: TextFormField(
                              onChanged: (password) {
                                onPasswordChanged(password);
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return null;
                                } else if (value.length < 6) {
                                  return 'bitte mindestens 6 Zeichen eingeben';
                                }
                                return null;
                              },
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              controller: _newPwRepeatController,
                              keyboardType: TextInputType.text,
                              obscureText: _isOldPasswordVisible ? true : false,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: AppColor.kPrimaryButtonColor,
                                    width: 2,
                                  ),
                                ),
                                filled: true,
                                fillColor: const Color.fromARGB(255, 231, 226, 226),
                              ).copyWith(
                                contentPadding: const EdgeInsets.all(12),
                                isDense: true,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _isOldPasswordVisible = !_isOldPasswordVisible;
                                    });
                                  },
                                  icon: _isOldPasswordVisible
                                      ? const Icon(Icons.visibility_off)
                                      : const Icon(Icons.visibility),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      const BorderSide(color: Color.fromARGB(255, 231, 226, 226)),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(color: Colors.red),
                                ),
                              ),
                            ),
                          )),
                      const SizedBox(
                        height: 22,
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Passwort wiederholen',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Focus(
                        onFocusChange: (hasFocus) {
                          setState(() {
                            isFocused = hasFocus;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          height: isFocused ? 44 : 40,
                          child: TextFormField(
                            onChanged: (password) {
                              onPasswordChanged(password);
                            },
                            validator: (value) {
                              if (value!.isEmpty || value.length < 6) {
                                return 'Bitte mindestens 6 Zeichen eingeben';
                              }
                              return null;
                            },
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            controller: _newPwController,
                            keyboardType: TextInputType.text,
                            obscureText: isVisable,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: AppColor.kPrimaryButtonColor,
                                  width: 2,
                                ),
                              ),
                              filled: true,
                              fillColor: const Color.fromARGB(255, 231, 226, 226),
                              contentPadding: const EdgeInsets.all(12),
                              isDense: true,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isVisable = !isVisable;
                                  });
                                },
                                icon: Icon(
                                  isVisable ? Icons.visibility : Icons.visibility_off,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: isPassword6Char ? Colors.green : Colors.white,
                                      border: Border.all(
                                        color: const Color.fromARGB(255, 189, 189, 189),
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                  ),
                                  const SizedBox(width: 11),
                                  const Text('bitte 6 Zeichen eingeben'),
                                ],
                              ),
                              const SizedBox(
                                height: 9,
                              ),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 20,
                                        width: 20,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: isPasswordHas1Number ? Colors.green : Colors.white,
                                          border: Border.all(
                                              color: const Color.fromARGB(255, 189, 189, 189)),
                                        ),
                                        child: const Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 15,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 11,
                                      ),
                                      const Text('mindenstens 1 Nummer'),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 9,
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: hasUppercase ? Colors.green : Colors.white,
                                      border: Border.all(
                                          color: const Color.fromARGB(255, 189, 189, 189)),
                                    ),
                                    child: const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 11,
                                  ),
                                  const Text('Großbuchstabe'),
                                ],
                              ),
                              const SizedBox(
                                height: 11,
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: hasLowercase ? Colors.green : Colors.white,
                                      border: Border.all(
                                          color: const Color.fromARGB(255, 189, 189, 189)),
                                    ),
                                    child: const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 11,
                                  ),
                                  const Text('Kleinbuchstabe '),
                                ],
                              ),
                              const SizedBox(
                                height: 11,
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: hasSpecialCharacters ? Colors.green : Colors.white,
                                      border: Border.all(
                                          color: const Color.fromARGB(255, 189, 189, 189)),
                                    ),
                                    child: const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 11,
                                  ),
                                  const Text('Sonderzeichen '),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 33,
                      ),
                      Center(
                        child: Consumer(
                          builder: (context, ref, child) => SizedBox(
                            width: 320,
                            height: 44,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  if (_newPwController.text == _newPwRepeatController.text) {
                                    ref
                                        .read(userProvider.notifier)
                                        .setNewPassword(_userNameController.text,
                                            _oTPController.text, _newPwController.text)
                                        .then((e) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Center(
                                            child: Text(e
                                                ? 'Passwort erfolgreich geändert'
                                                : 'Leider ist etwas schief überprüfen sie ihre Daten'),
                                          ),
                                        ),
                                      );
                                      e
                                          ? {
                                              Navigator.of(context)
                                                  .pushReplacementNamed(AppRoutes.viewScreen),
                                              ref.read(userProvider.notifier).loginUser(
                                                  password: _newPwController.text,
                                                  userName: _userNameController.text),
                                            }
                                          : null;
                                    });
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                      content: Text(
                                        'Die Passwörter stimmen nicht überein. Bitte versuche es erneut.',
                                      ),
                                    ));
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                    content: Center(child: Text(' Error .')),
                                  ));
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                backgroundColor: AppColor.kPrimaryButtonColor,
                              ),
                              child: const Center(
                                child: Text(
                                  'Speichern',
                                  style:
                                      TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                                ),
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
          ),
        ),
      );
}
