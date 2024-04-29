import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';

class PasswordView extends StatefulWidget {
  const PasswordView({super.key});

  @override
  State<PasswordView> createState() => _PasswordViewState();
}

class _PasswordViewState extends State<PasswordView> {
  bool isFocused = false;
  bool isOTP = false;
  bool _isOldPasswordVisible = false;
  bool isVisable = true;
  bool isPasswordVisible = false;

  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final newpasswordController = TextEditingController();
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
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                // You can add other style properties here as needed
                              ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Altes Passwort',
                          style: TextStyle(fontWeight: FontWeight.bold),
                          //  Theme.of(context)
                          //     .textTheme
                          //     .bodyLarge
                          //     ?.copyWith(
                          //         color: const Color.fromARGB(
                          //             192, 255, 255, 255),
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
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 224, 142, 60),
                                    width: 2,
                                  ),
                                ),
                                filled: true,
                                fillColor:
                                    const Color.fromARGB(255, 231, 226, 226),
                              ).copyWith(
                                contentPadding: const EdgeInsets.all(12),
                                isDense: true,
                              ),
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
                            //  Theme.of(context)
                            //     .textTheme
                            //     .bodyLarge
                            //     ?.copyWith(
                            //         color: const Color.fromARGB(
                            //             192, 255, 255, 255),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // Container(
                      //   width: 350,
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(8),
                      //     color: const Color.fromARGB(255, 231, 226, 226),
                      //   ),
                      //   child: Focus(
                      //     onFocusChange: (hasFocus) {
                      //       setState(() {
                      //         isFocused = hasFocus;
                      //       });
                      //     },
                      //     child: AnimatedContainer(
                      //       duration: const Duration(milliseconds: 300),
                      //       height: isFocused ? 44 : 40,
                      //       child: TextFormField(
                      //         textInputAction: TextInputAction.next,
                      //         validator: (value) =>
                      //             value!.length < 6 ? 'Required' : null,
                      //         obscureText: !_isPasswordVisible,
                      //         controller: passCon,
                      //         decoration: InputDecoration(
                      //           filled: true,
                      //           fillColor: Colors.transparent,
                      //           suffixIcon: IconButton(
                      //             onPressed: () {
                      //               setState(() {
                      //                 _isPasswordVisible =
                      //                     !_isPasswordVisible; // Toggle visibility
                      //               });
                      //             },
                      //             icon: Icon(
                      //               _isPasswordVisible
                      //                   ? Icons.visibility_off
                      //                   : Icons
                      //                       .visibility, // Toggle the icon based on the state
                      //               color: Theme.of(context).iconTheme.color,
                      //             ),
                      //           ),
                      //           contentPadding: const EdgeInsets.all(10),
                      //           focusedBorder: OutlineInputBorder(
                      //             borderRadius: BorderRadius.circular(8),
                      //             borderSide: const BorderSide(
                      //                 color: Color.fromARGB(255, 224, 142, 60)),
                      //           ),
                      //           enabledBorder: OutlineInputBorder(
                      //             borderRadius: BorderRadius.circular(12),
                      //             borderSide: BorderSide(
                      //               color: isFocused
                      //                   ? const Color.fromARGB(
                      //                       255, 224, 142, 60)
                      //                   : Colors.transparent,
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),

                      // Align(
                      //   alignment: Alignment.centerLeft,
                      //   child: Text(
                      //     'Neues Passwort',
                      //     style: Theme.of(context)
                      //         .textTheme
                      //         .headlineSmall
                      //         ?.copyWith(fontSize: 16),
                      //   ),
                      // ),
                      // TextFormField(
                      //   onChanged: (password) {
                      //     setState(() {
                      //       newpasswordController.text = password;
                      //     });
                      //     onPasswordChanged(password);
                      //   },

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
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: newpasswordController,
                              keyboardType: TextInputType.text,
                              obscureText: _isOldPasswordVisible ? true : false,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 224, 142, 60),
                                    width: 2,
                                  ),
                                ),
                                filled: true,
                                fillColor:
                                    const Color.fromARGB(255, 231, 226, 226),
                              ).copyWith(
                                contentPadding: const EdgeInsets.all(12),
                                isDense: true,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _isOldPasswordVisible =
                                          !_isOldPasswordVisible;
                                    });
                                  },
                                  icon: _isOldPasswordVisible
                                      ? const Icon(Icons.visibility_off)
                                      : const Icon(Icons.visibility),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color:
                                          Color.fromARGB(255, 231, 226, 226)),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      const BorderSide(color: Colors.red),
                                ),
                              ),
                            ),
                          )),

                      const SizedBox(
                        height: 7,
                      ),
                      const SizedBox(
                        height: 15,
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
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: passwordController,
                            keyboardType: TextInputType.text,
                            obscureText: isVisable,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Colors
                                      .transparent, // Default state border color
                                  width: 1,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 224, 142, 60),
                                  width: 2,
                                ),
                              ),

                              // focusedBorder: OutlineInputBorder(
                              //   borderRadius: BorderRadius.circular(8),
                              //   borderSide: const BorderSide(
                              //     color: Color.fromARGB(255, 224, 142,
                              //         60), // Orange color when focused
                              //     width: 2,
                              //   ),
                              // ),
                              filled: true,
                              fillColor: const Color.fromARGB(
                                  255, 231, 226, 226), // Background color
                              contentPadding: const EdgeInsets.all(12),
                              isDense: true,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isVisable = !isVisable;
                                  });
                                },
                                icon: Icon(
                                  isVisable
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  // color: Colors.grey,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide:
                                      BorderSide.none // Red border on error
                                  ),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      BorderSide.none // Red border on error
                                  // Red border w
                                  //hen focused and error
                                  ),
                            ),
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
                                      color: isPassword6Char
                                          ? Colors.green
                                          : Colors.white,
                                      border: Border.all(
                                        color: const Color.fromARGB(
                                            255, 189, 189, 189),
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
                                          color: isPasswordHas1Number
                                              ? Colors.green
                                              : Colors.white,
                                          border: Border.all(
                                              color: const Color.fromARGB(
                                                  255, 189, 189, 189)),
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
                                      color: hasUppercase
                                          ? Colors.green
                                          : Colors.white,
                                      border: Border.all(
                                          color: const Color.fromARGB(
                                              255, 189, 189, 189)),
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
                                      color: hasLowercase
                                          ? Colors.green
                                          : Colors.white,
                                      border: Border.all(
                                          color: const Color.fromARGB(
                                              255, 189, 189, 189)),
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
                                      color: hasSpecialCharacters
                                          ? Colors.green
                                          : Colors.white,
                                      border: Border.all(
                                          color: const Color.fromARGB(
                                              255, 189, 189, 189)),
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
                          width: 320,
                          height: 44,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // Check if the new password matches the confirmation password
                                if (passwordController.text ==
                                    newpasswordController.text) {
                                  // Proceed with updating the password
                                  // Replace this line with the appropriate logic to update the password
                                  // For example, you might call an API to update the password
                                  // Once the password is updated successfully, navigate to the login view
                                  Navigator.pushReplacementNamed(
                                      context, AppRoutes.anmeldeScreen);
                                } else {
                                  // Show error if passwords don't match
                                }
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text(
                                    'Die Passwörter stimmen nicht überein. Bitte versuche es erneut.',
                                  ),
                                ));
                              } else {
                                // Show error if form validation fails

                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
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
                              backgroundColor:
                                  const Color.fromARGB(255, 224, 142, 60),
                            ),
                            child: const Center(
                              child: Text(
                                'Speichern',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
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
