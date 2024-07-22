import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../constants/themes/app_color.dart';
import '../../provider/user_provider/user_provider.dart';
import '../../routes/app_routes.dart';
import '../shared_widgets/snackbar.dart';
import 'custome_textfield_login.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  bool isUsernameFocused = false;
  bool isPasswordFocused = false;
  bool _isLoaded = false;

  late final TextEditingController _emailCon;
  late final TextEditingController _passCon;
  late final GlobalKey<FormState> _formstate;

  @override
  void initState() {
    super.initState();
    _emailCon = TextEditingController();
    _passCon = TextEditingController();
    _formstate = GlobalKey<FormState>();
  }

  String? validateEmail(String? input) {
    const emailRegex = r'^(\S+@[^\s@]+\.\S+)$';

    if (input == null || input.isEmpty) {
      return 'Email bitte eingeben';
    } else if (RegExp(emailRegex).hasMatch(input)) {
      return null;
    } else {
      return 'Ungültige Nutzernamen Format';
    }
  }

  String? validatePassword(String? input) {
    if (input == null || input.isEmpty) {
      return 'Passwort bitte eingeben';
    } else if (input.length >= 6) {
      return null;
    } else {
      return 'Mehr als 6 Zeichen bitte eingeben';
    }
  }

  @override
  void dispose() {
    _emailCon.dispose();
    _passCon.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 60),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 46,
                      child: Image.asset('assets/images/img_techtool.png'),
                    ),
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
                              child: Text(
                                'Nutzername',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          CustomTextField(
                            controller: _emailCon,
                            inputAction: TextInputAction.next,
                            validator: validateEmail,
                            onFieldSubmitted: (_) => _submitLogin(),
                            onFocusChange: (hasFocus) {
                              setState(() => isUsernameFocused = hasFocus);
                            },
                            autofillHints: const [AutofillHints.email],
                          ),
                          const SizedBox(
                            width: 350,
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                'Passwort',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            controller: _passCon,
                            isPassword: true,
                            inputAction: TextInputAction.done,
                            validator: validatePassword,
                            onFieldSubmitted: (_) => _submitLogin(),
                            onFocusChange: (hasFocus) {
                              setState(() => isPasswordFocused = hasFocus);
                            },
                            autofillHints: const [AutofillHints.password],
                          ),
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
          ),
        ),
      );

  void reactionOfLogin(bool isSuccess) {
    setState(() => _isLoaded = false);
    if (isSuccess) {
      Navigator.of(context).pushReplacementNamed(AppRoutes.viewScreen);
    } else {
      showSnackBar(
          context, 'Anmeldung fehlgeschlagen.\nBitte überprüfen Sie Ihre Zugangsdaten und versuchen Sie es erneut.');
      _passCon.clear();
    }
  }

  Future<void> _submitLogin() async {
    if (_formstate.currentState!.validate()) {
      final String email = _emailCon.text;
      final String password = _passCon.text;

      setState(() {
        _isLoaded = true;
      });

      try {
        bool isSuccess = await ref.read(userProvider.notifier).loginUser(
              password: password,
              userName: email,
            );

        reactionOfLogin(isSuccess);
      } catch (e) {
        setState(() {
          _isLoaded = false;
        });
        showSnackBar(context, 'Leider hat es nicht geklappt: ${e.toString()}');
      }
    } else {
      showSnackBar(context, 'Ungültige Nutzernamme oder Passwort Eingabe');
    }
  }

  Widget _buildForgotPassword() => SizedBox(
        width: 350,
        child: Align(
          alignment: Alignment.topRight,
          child: GestureDetector(
            child: Text(
              'Passwort vergessen?',
              style: TextStyle(
                color: AppColor.kWhite,
                fontWeight: FontWeight.w700,
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
              ? SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(AppColor.kPrimaryButtonColor),
                  ),
                )
              : SizedBox(
                  width: 340,
                  height: 44,
                  child: ElevatedButton(
                    onPressed: _submitLogin,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: AppColor.kPrimaryButtonColor,
                    ),
                    child: Center(
                      child: Text(
                        'Anmelden',
                        style: TextStyle(color: AppColor.kWhite),
                      ),
                    ),
                  ),
                ),
        ),
      );
}
