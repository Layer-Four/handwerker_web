import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/themes/app_color.dart';
import '../../provider/user_provider/user_provider.dart';
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
                          child:
                              Text('Mandatenname', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),
                      const SizedBox(height: 3),
                      _buildUsernameTextField(emailCon, 'Bitte eine gültige Mandatenname eingeben'),
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

  Widget _buildUsernameTextField(TextEditingController controller, String errorMessage) =>
      Container(
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
              autofocus: true,
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
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('leider hats nicht geklappt')));
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
                            .then((value) {
                          reactionOfLogin(value);
                          SharedPreferences.getInstance().then((value) {
                            final token = value.getString('TOKEN');
                            log(token.toString());
                          });
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
  bool validateFields() {
    if (formstate.currentState == null) {
      return false;
    }

    bool isValid =
        formstate.currentState!.validate() && emailCon.text.isNotEmpty && passCon.text.isNotEmpty;
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
