import 'dart:developer';

import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isFocused = false;
  bool isOTP = false;
  bool _isPasswordVisible = false; // Tracks password visibility

  TextEditingController emailCon = TextEditingController();
  TextEditingController passCon = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey();
  @override
  Widget build(BuildContext context) => Scaffold(
        // body: BackgroundWidget(
        body: Padding(
          padding: const EdgeInsets.only(
            top: 60,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 90,
                ),
                SizedBox(
                  height: 44,
                  child: Image.asset(
                    'assets/images/img_techtool.png',
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                // Align(
                //   alignment: Alignment.centerLeft,
                //   child: Text(
                //     'Anmelden',
                //     style: Theme.of(context)
                //         .textTheme
                //         .headlineSmall
                //         ?.copyWith(color: const Color.fromARGB(192, 255, 255, 255)),
                //   ),
                // ),
                const SizedBox(
                  height: 15,
                ),
                Form(
                  key: formstate,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 350,
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            'Mandatenname',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            // Theme.of(context)
                            //     .textTheme
                            //     .bodyMedium
                            //     ?.copyWith(
                            //         color: const Color.fromARGB(
                            //             192, 255, 255, 255),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Container(
                        width: 355,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color.fromARGB(255, 231, 226, 226),
                        ),
                        child: Focus(
                          onFocusChange: (hasFocus) {
                            setState(() {
                              isFocused = hasFocus;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            height: isFocused ? 44 : 40,
                            child: TextFormField(
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return null;
                                } else if (value.length < 3) {
                                  return 'Bitte eine gültige Mandatenname eingeben';
                                }
                                return null;
                              },
                              controller: emailCon,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.transparent,
                                contentPadding: const EdgeInsets.all(
                                    10), // Ensure uniform padding
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 224, 142, 60),
                                    width: 2,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: isFocused
                                        ? const Color.fromARGB(
                                            255, 224, 142, 60)
                                        : Colors.transparent,
                                    width: 1,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                      color: Colors.red, width: 2),
                                ),
                                errorStyle: const TextStyle(
                                    height: 0.5), // Adjust as needed
                              ),
                            ),
                          ),
                        ),
                      ),

                      // UserAndPasswordField(
                      //   controller: emailCon,
                      //   validator: (value) {
                      //     if (value!.isEmpty) {
                      //       return 'Please enter your email';
                      //     }
                      //     // Additional validation logic if needed
                      //     return null; // Return null if the value is valid
                      //   },
                      // ),
                      const SizedBox(
                        height: 20,
                      ),
                      const SizedBox(
                        width: 350,
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            'Passwort',
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
                        height: 3,
                      ),
                      Container(
                        width: 350,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color.fromARGB(255, 231, 226, 226),
                        ),
                        child: Focus(
                          onFocusChange: (hasFocus) {
                            setState(() {
                              isFocused = hasFocus;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            height: isFocused ? 44 : 40,
                            child: TextFormField(
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return null;
                                } else if (value.length < 6) {
                                  return 'Bitte eine gültige Passwort eingeben';
                                }
                                return null;
                              },
                              obscureText: !_isPasswordVisible,
                              controller: passCon,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.transparent,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _isPasswordVisible =
                                          !_isPasswordVisible; // Toggle visibility
                                    });
                                  },
                                  icon: Icon(
                                    _isPasswordVisible
                                        ? Icons.visibility_off
                                        : Icons
                                            .visibility, // Toggle the icon based on the state
                                    color: Theme.of(context).iconTheme.color,
                                  ),
                                ),
                                contentPadding: const EdgeInsets.all(10),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 224, 142, 60)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: isFocused
                                        ? const Color.fromARGB(
                                            255, 224, 142, 60)
                                        : Colors.transparent,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none),
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        width: 350,
                        child: Align(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            child: const Text(
                              'Passwort vergessen?',
                              style: TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.w700,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.orange,
                                decorationThickness: 2.0,
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(AppRoutes.forgotPassword);
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Switch(
                          value: isOTP,
                          onChanged: (value) {
                            setState(() {
                              isOTP = value;
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: SizedBox(
                          width: 335,
                          height: 44,
                          child: ElevatedButton(
                            onPressed: () {
                              if (formstate.currentState!.validate()) {
                                log('valid');
                              } else {
                                log('Not Valid');
                              }
                              if (isOTP) {
                                Navigator.of(context)
                                    .pushNamed(AppRoutes.setPasswordScreen);
                              } else {
                                Navigator.of(context)
                                    .pushReplacementNamed(AppRoutes.viewScreen);
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
                                'Anmelden',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        // imageName: 'img_anmelden.png'),
      );
}
