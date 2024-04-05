import 'dart:developer';
import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';

class PasswordView extends StatefulWidget {
  const PasswordView({super.key});

  @override
  State<PasswordView> createState() => _PasswordViewState();
}

class _PasswordViewState extends State<PasswordView> {
  bool isVisable = true;
  bool isPasswordVisible = false;

  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final newpasswordController = TextEditingController();

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
    passwordController.dispose();
    newpasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          toolbarHeight: 30.0,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 33, right: 33),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    child: Image.asset('assets/images/img_anmelden.png'),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Passwort ändern',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Altes Passwort',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 16),
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    obscureText: false,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(),
                      ),
                      filled: true,
                    ).copyWith(
                      contentPadding: const EdgeInsets.all(8),
                      // isDense: true,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Neues Passwort',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 16),
                    ),
                  ),
                  TextFormField(
                    onChanged: (password) {
                      setState(() {
                        newpasswordController.text = password;
                      });
                      log(newpasswordController.text);
                      onPasswordChanged(password);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return null;
                      } else if (value.length < 6) {
                        return 'Enter at least 6 Zeichen';
                      }

                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: newpasswordController,
                    keyboardType: TextInputType.text,
                    obscureText: isVisable ? true : false,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(),
                      ),
                      filled: true,
                    ).copyWith(
                      contentPadding: const EdgeInsets.all(8),
                      isDense: true,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isVisable = !isVisable;
                          });
                        },
                        icon: isVisable
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Passwort widerholen',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 16),
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  TextFormField(
                    onChanged: (password) {
                      onPasswordChanged(password);
                    },
                    validator: (value) => value!.length < 6 ? 'Enter at least 6 characters' : null,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: passwordController,
                    keyboardType: TextInputType.text,
                    obscureText: isVisable ? true : false,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(),
                      ),
                      filled: true,
                    ).copyWith(
                      contentPadding: const EdgeInsets.all(8),
                      isDense: true,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isVisable = !isVisable;
                          });
                        },
                        icon: isVisable
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  const SizedBox(
                    height: 15,
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
                                  border:
                                      Border.all(color: const Color.fromARGB(255, 189, 189, 189)),
                                ),
                                child: const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 15,
                                ),
                              ),
                              const SizedBox(width: 11),
                              const Text('mindestens 6 Zeichen'),
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
                                  border:
                                      Border.all(color: const Color.fromARGB(255, 189, 189, 189)),
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
                                  border:
                                      Border.all(color: const Color.fromARGB(255, 189, 189, 189)),
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
                                  border:
                                      Border.all(color: const Color.fromARGB(255, 189, 189, 189)),
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
                    child: SizedBox(
                      width: 235,
                      height: 35,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Check if the new password matches the confirmation password
                            if (passwordController.text == newpasswordController.text) {
                              // Proceed with updating the password
                              // Replace this line with the appropriate logic to update the password
                              // For example, you might call an API to update the password
                              // Once the password is updated successfully, navigate to the login view
                              Navigator.pushReplacementNamed(context, AppRoutes.anmeldeScreen);
                            } else {
                              // Show error if passwords don't match
                            }
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text(
                                'Die Passwörter stimmen nicht überein. Bitte versuche es erneut.',
                              ),
                            ));
                          } else {
                            // Show error if form validation fails

                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text(
                                ' Error .',
                              ),
                            ));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          backgroundColor: const Color.fromARGB(255, 224, 142, 60),
                        ),
                        child: const Center(
                          child: Text(
                            'Speichern',
                            style: TextStyle(color: Colors.white),
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
