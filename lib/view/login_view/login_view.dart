import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../constants/themes/app_color.dart';
import '../../constants/utilitis/utilitis.dart';
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

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // TODO: would be on Login Screen a be Logo image
              const SizedBox(height: 75),
              Form(
                key: _formstate,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 350,
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text('Mandatenname', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                    _buildUsernameTextField(),
                    const SizedBox(
                      width: 350,
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text('Passwort', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                    _buildPasswordTextField(),
                    _buildForgotPassword(),
                    _buildLoginButton(),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  void reactionOfLogin(bool isSuccess) {
    setState(() => _isLoaded = false);
    if (isSuccess) {
      Navigator.of(context).pushReplacementNamed(AppRoutes.viewScreen);
      return;
    }
    _passCon.clear();
    return Utilitis.showSnackBar(
      context,
      'leider hat es nicht geklappt.\nKontrolliere deine Zugangsdaten und versuche es erneut',
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
  }

  Widget _buildUsernameTextField() => Container(
        padding: const EdgeInsets.only(top: 3, bottom: 20),
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
                  borderSide: BorderSide(
                    color: AppColor.kPrimaryButtonColor,
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
        padding: const EdgeInsets.only(top: 3, bottom: 5),
        width: 350,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColor.kTextfieldBorder,
        ),
        child: Focus(
          onFocusChange: (hasFocus) => setState(() => isFocused = hasFocus),
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
                  borderSide: BorderSide(
                    color: AppColor.kPrimaryButtonColor,
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

  Widget _buildLoginButton() => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
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
        ),
      );

  bool validateFields() {
    if (_formstate.currentState == null) {
      return false;
    }

    bool isValid = _formstate.currentState!.validate() &&
        _emailCon.text.isNotEmpty &&
        _passCon.text.isNotEmpty;
    if (!isValid) {
      Utilitis.showSnackBar(context, 'Bitte füllen Sie alle Felder korrekt aus.');
    }
    return isValid;
  }
}
