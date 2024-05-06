// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../constants/themes/app_color.dart';
// import '../../provider/settings_provider/user_provider_.dart';
// import '../../routes/app_routes.dart';
// import '../shared_view_widgets/background_widget.dart';
// import '../widgets/logo.dart';
// import 'textfield_widgets/text_field.dart';

// class LoginView extends StatefulWidget {
//   const LoginView({super.key});

//   @override
//   State<LoginView> createState() => _LoginViewState();
// }

// class _LoginViewState extends State<LoginView> {
//   bool isOTP = false;
//   final TextEditingController _userNameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   GlobalKey<FormState> formstate = GlobalKey();

//   void reactionOfLogin(bool isSuccess) async {
//     if (isSuccess) {
//       _userNameController.clear();
//       _passwordController.clear();
//       Navigator.of(context).pushReplacementNamed(AppRoutes.viewScreen);
//       return;
//     }
//     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('leider hats nicht geklappt')));
//   }

//   @override
//   Widget build(BuildContext context) => Scaffold(
//         body: BackgroundWidget(
//             body: Padding(
//               padding: const EdgeInsets.only(top: 60, left: 40, right: 40),
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     const AppLogo(),
//                     const SizedBox(
//                       height: 9,
//                     ),
//                     Align(
//                       alignment: Alignment.centerLeft,
//                       child: Text(
//                         'Anmelden',
//                         style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: AppColor.kWhiteWOpacity),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 15,
//                     ),
//                     Form(
//                       key: formstate,
//                       autovalidateMode: AutovalidateMode.onUserInteraction,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Nutzername',
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .bodyMedium
//                                 ?.copyWith(color: AppColor.kWhiteWOpacity, fontWeight: FontWeight.bold),
//                           ),
//                           const SizedBox(
//                             height: 3,
//                           ),
//                           UserAndPasswordField(
//                             controller: _userNameController,
//                             validator: (value) {
//                               if (value!.isEmpty) {
//                                 return 'Please enter your email';
//                               }
//                               return null;
//                             },
//                           ),
//                           const SizedBox(
//                             height: 20,
//                           ),
//                           Text(
//                             'Passwort',
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .bodyLarge
//                                 ?.copyWith(color: AppColor.kWhiteWOpacity, fontWeight: FontWeight.bold),
//                           ),
//                           const SizedBox(
//                             height: 3,
//                           ),
//                           UserAndPasswordField(
//                             controller: _passwordController,
//                             isPass: true,
//                           ),
//                           const SizedBox(
//                             height: 5,
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(8),
//                             child: Switch(
//                               value: isOTP,
//                               onChanged: (value) {
//                                 setState(() {
//                                   isOTP = value;
//                                 });
//                               },
//                             ),
//                           ),
//                           Align(
//                             alignment: Alignment.topRight,
//                             child: Padding(
//                               padding: const EdgeInsets.only(right: 8),
//                               child: GestureDetector(
//                                 child: Text(
//                                   'Passwort vergessen?',
//                                   style: TextStyle(color: AppColor.kWhite, fontWeight: FontWeight.w500),
//                                 ),
//                                 onTap: () {
//                                   Navigator.of(context).pushNamed(AppRoutes.forgotPassword);
//                                 },
//                               ),
//                             ),
//                           ),
//                           const SizedBox(
//                             height: 20,
//                           ),
//                           Center(
//                             child: SizedBox(
//                               width: 235,
//                               height: 35,
//                               child: Consumer(
//                                   builder: (context, ref, child) => ElevatedButton(
//                                         onPressed: () async {
//                                           if (formstate.currentState!.validate()) {
//                                             ref
//                                                 .read(userProvider.notifier)
//                                                 .loginUser(
//                                                   password: _passwordController.text,
//                                                   userName: _userNameController.text,
//                                                 )
//                                                 .then((value) => reactionOfLogin(value));
//                                             SharedPreferences.getInstance().then((value) {
//                                               // final token =
//                                               //     value.getString('TOKEN');
//                                               // log(token.toString() as num);
//                                             });
//                                           }
//                                           if (isOTP) {
//                                             Navigator.of(context).pushNamed(AppRoutes.setPasswordScreen);
//                                           }
//                                         },
//                                         style: ElevatedButton.styleFrom(
//                                           shape: RoundedRectangleBorder(
//                                             borderRadius: BorderRadius.circular(8),
//                                           ),
//                                           backgroundColor: AppColor.kPrimaryButtonColor,
//                                         ),
//                                         child: const Center(
//                                           child: Text(
//                                             'Anmelden',
//                                             style: TextStyle(color: Colors.white),
//                                           ),
//                                         ),
//                                       )),
//                             ),
//                           ),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//             imageName: 'img_anmelden.png'),
//       );
// }

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import '../../constants/themes/app_color.dart';
import '../../constants/themes/app_color.dart';
import '../../provider/settings_provider/user_provider.dart';
// import '../../provider/settings_provider/user_provider_.dart';
import '../../routes/app_routes.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isFocused = false;
  bool isOTP = false;
  bool _isPasswordVisible = false;

  TextEditingController emailCon = TextEditingController();
  TextEditingController passCon = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 60),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 90),
                SizedBox(
                  height: 44,
                  child: Image.asset('assets/images/img_techtool.png'),
                ),
                const SizedBox(height: 60),
                const SizedBox(height: 15),
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
                          child: Text('Mandatenname', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),
                      const SizedBox(height: 3),
                      buildTextField(emailCon, 'Bitte eine gültige Mandatenname eingeben'),
                      const SizedBox(height: 20),
                      const SizedBox(
                        width: 350,
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text('Passwort', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),
                      const SizedBox(height: 3),
                      buildPasswordTextField(),
                      const SizedBox(height: 5),
                      buildForgotPassword(context),
                      // Padding(
                      //   padding: const EdgeInsets.all(8),
                      //   child: Switch(
                      //     value: isOTP,
                      //     onChanged: (value) {
                      //       setState(() => isOTP = value);
                      //     },
                      //   ),
                      // ),
                      const SizedBox(height: 20),
                      buildLoginButton(context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget buildTextField(TextEditingController controller, String errorMessage) => Container(
        width: 355,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color.fromARGB(255, 231, 226, 226),
        ),
        child: Focus(
          onFocusChange: (hasFocus) {
            setState(() => isFocused = hasFocus);
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
                  return errorMessage;
                }
                return null;
              },
              controller: controller,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.transparent,
                contentPadding: const EdgeInsets.all(10),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 224, 142, 60),
                    width: 2,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                    width: 0,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                    width: 0,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                    width: 0,
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  Widget buildPasswordTextField() => Container(
        width: 350,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color.fromARGB(255, 231, 226, 226),
        ),
        child: Focus(
          onFocusChange: (hasFocus) {
            setState(() => isFocused = hasFocus);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: isFocused ? 44 : 40,
            child: TextFormField(
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value!.isEmpty) {
                  return null; // Let the SnackBar handle the empty case
                } else if (value.length < 7) {
                  return 'Bitte mehr als 6 Buchstaben eingeben';
                }
                return null;
              },
              obscureText: !_isPasswordVisible,
              controller: passCon,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.transparent,
                suffixIcon: IconButton(
                  onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                  icon: Icon(_isPasswordVisible ? Icons.visibility_off : Icons.visibility),
                  color: Theme.of(context).iconTheme.color,
                ),
                contentPadding: const EdgeInsets.all(10),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 224, 142, 60),
                    width: 2,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                    width: 0,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                    width: 0,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                    width: 0,
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  Widget buildForgotPassword(BuildContext context) => SizedBox(
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
            onTap: () => Navigator.of(context).pushNamed(AppRoutes.forgotPassword),
          ),
        ),
      );

  void reactionOfLogin(bool isSuccess) async {
    if (isSuccess) {
      emailCon.clear();
      passCon.clear();
      Navigator.of(context).pushReplacementNamed(AppRoutes.viewScreen);
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('leider hats nicht geklappt')));
  }

  Widget buildLoginButton(BuildContext context) => Center(
        child: SizedBox(
          width: 340,
          height: 44,
          child: Consumer(
              builder: (context, ref, child) => ElevatedButton(
                    onPressed: () async {
                      if (formstate.currentState!.validate()) {
                        ref
                            .read(userProvider.notifier)
                            .loginUser(
                              password: passCon.text,
                              userName: emailCon.text,
                            )
                            .then((value) => reactionOfLogin(value));
                        SharedPreferences.getInstance().then((value) {
                          final token = value.getString('TOKEN');
                          log(token.toString());
                        });
                      }
                      if (isOTP) {
                        Navigator.of(context).pushNamed(AppRoutes.setPasswordScreen);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: AppColor.kPrimaryButtonColor,
                    ),
                    child: const Center(
                      child: Text(
                        'Anmelden',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )),
        ),
      );

  //  Center(
  //       child: SizedBox(
  //         width: 335,
  //         height: 44,
  //         child: ElevatedButton(
  //           onPressed: () {
  //             if (validateFields()) {
  //               // Both fields are filled and valid
  //               if (isOTP) {
  //                 Navigator.of(context).pushNamed(AppRoutes.setPasswordScreen);
  //               } else {
  //                 Navigator.of(context).pushReplacementNamed(AppRoutes.viewScreen);
  //               }
  //             }
  //           },
  //           style: ElevatedButton.styleFrom(
  //             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  //             backgroundColor: const Color.fromARGB(255, 224, 142, 60),
  //           ),
  //           child: const Center(
  //             child: Text('Anmelden', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
  //           ),
  //         ),
  //       ),
  //     );

  bool validateFields() {
    if (formstate.currentState == null) {
      return false;
    }

    bool isValid = formstate.currentState!.validate() && emailCon.text.isNotEmpty && passCon.text.isNotEmpty;
    if (!isValid) {
      showSnackBar('Bitte füllen Sie alle Felder korrekt aus.');
    }
    return isValid;
  }

  void showSnackBar(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
