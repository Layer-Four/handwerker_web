import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../constants/themes/app_color.dart';
import '../../provider/user_provider/user_provider.dart';
import '../../routes/app_routes.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  bool isFocused = false;
  bool isOTP = false;
  bool _isPasswordVisible = false;
  bool _isLoaded = false;

  final TextEditingController _emailCon = TextEditingController();
  final TextEditingController _passCon = TextEditingController();
  final GlobalKey<FormState> _formstate = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailCon.dispose();
    _passCon.dispose();
    super.dispose();
  }

  void reactionOfLogin(bool isSuccess) {
    setState(() => _isLoaded = false);
    if (isSuccess) {
      _emailCon.clear();
      _passCon.clear();
      Navigator.of(context).pushReplacementNamed(AppRoutes.viewScreen);
      return;
    }
    _passCon.clear();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Center(
          child: Text(
            'leider hat es nicht geklappt.\nKontrolliere deine Zugangsdaten und versuche es erneut',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Future<void> _submitLogin() async {
    if (_formstate.currentState!.validate()) {
      setState(() => _isLoaded = true);
      bool isSuccess = await ref.read(userProvider.notifier).loginUser(
            password: _passCon.text,
            userName: _emailCon.text,
          );
      reactionOfLogin(isSuccess);
    }
    if (isOTP) {
      Navigator.of(context).pushNamed(AppRoutes.setPasswordScreen);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 60),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 60),
                const SizedBox(height: 15),
                Form(
                  key: _formstate,
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
                      _buildUsernameTextField(),
                      const SizedBox(height: 20),
                      const SizedBox(
                        width: 350,
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text('Passwort', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),
                      const SizedBox(height: 3),
                      _buildPasswordTextField(),
                      const SizedBox(height: 5),
                      _buildForgotPassword(),
                      const SizedBox(height: 20),
                      _buildLoginButton(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget _buildUsernameTextField() => Container(
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
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value!.isEmpty) {
                  return null;
                } else if (value.isNotEmpty && value.length < 3) {
                  return 'Bitte eine gültige Mandatenname eingeben';
                }
                return null;
              },
              onFieldSubmitted: (_) => _submitLogin(),
              controller: _emailCon,
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

  Widget _buildPasswordTextField() => Container(
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
              textInputAction: TextInputAction.done,
              validator: (value) {
                if (value!.isEmpty) {
                  return null;
                } else if (value.length < 7) {
                  return 'Bitte mehr als 6 Buchstaben eingeben';
                }
                return null;
              },
              onFieldSubmitted: (_) => _submitLogin(),
              obscureText: !_isPasswordVisible,
              controller: _passCon,
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

  Widget _buildForgotPassword() => SizedBox(
        width: 350,
        child: Align(
          alignment: Alignment.topRight,
          child: GestureDetector(
            child: Text(
              'Passwort vergessen?',
              style: TextStyle(
                color: AppColor.kPrimaryButtonColor,
                fontWeight: FontWeight.w700,
                decoration: TextDecoration.underline,
                decorationColor: AppColor.kPrimaryButtonColor,
                decorationThickness: 2.0,
              ),
            ),
            onTap: () => Navigator.of(context).pushReplacementNamed(AppRoutes.forgotPassword),
          ),
        ),
      );

  Widget _buildLoginButton() => Center(
        child: _isLoaded
            ? const SizedBox(
                child: CircularProgressIndicator(),
              )
            : SizedBox(
                width: 340,
                height: 44,
                child: ElevatedButton(
                  onPressed: () => _submitLogin(),
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
                ),
              ),
      );

  bool validateFields() {
    if (_formstate.currentState == null) {
      return false;
    }

    bool isValid = _formstate.currentState!.validate() && _emailCon.text.isNotEmpty && _passCon.text.isNotEmpty;
    if (!isValid) {
      showSnackBar('Bitte füllen Sie alle Felder korrekt aus.');
    }
    return isValid;
  }

  void showSnackBar(String message) {
    final snackBar = SnackBar(
      content: Center(child: Text(message)),
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
