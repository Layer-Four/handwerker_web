import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/themes/app_color.dart';
import '../../constants/utilitis/utilitis.dart';
import '../../provider/user_provider/user_provider.dart';
import '../../routes/app_routes.dart';

class ForgetScreen extends ConsumerStatefulWidget {
  const ForgetScreen({super.key});

  @override
  ConsumerState<ForgetScreen> createState() => _ForgetScreenState();
}

class _ForgetScreenState extends ConsumerState<ForgetScreen> {
  final TextEditingController _userNameController = TextEditingController();
  bool obscureText = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) => Scaffold(
        // backgroundColor: const Color.fromARGB(255, 254, 254, 245), //* DeckWeiss David,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
            ),
            onPressed: () => Navigator.of(context).pushReplacementNamed(AppRoutes.anmeldeScreen),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: SizedBox(
                width: 350,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 60),
                    SizedBox(
                      height: 46,
                      child: Image.asset('assets/images/img_techtool.png'),
                    ),
                    const SizedBox(height: 90),
                    SizedBox(
                      width: 350,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          child: Text(
                            'Passwort zurücksetzen',
                            style: TextStyle(
                              color: AppColor.kPrimaryButtonColor,
                              fontWeight: FontWeight.w700,
                              decorationColor: AppColor.kPrimaryButtonColor,
                              decorationThickness: 2.0,
                            ),
                          ),
                          onTap: () {},
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    const SizedBox(
                      width: 355,
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          'Nutzername',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(height: 11),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color.fromARGB(255, 231, 226, 226),
                      ),
                      child: Focus(
                        onFocusChange: (hasFocus) {
                          setState(() {});
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          height: 40,
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            validator: (value) => value!.length < 6 ? 'Inkorrekte Eingabe' : null,
                            obscureText: !obscureText,
                            controller: _userNameController,
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.transparent,
                              contentPadding: EdgeInsets.all(6),
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 140),
                    Consumer(
                        builder: (context, ref, child) => ElevatedButton(
                              onPressed: () {
                                if (_userNameController.text.isEmpty) {
                                  return Utilitis.showSnackBar(
                                      context, 'Geben sie einen gültigen Namen ein');
                                }
                                setState(() => isLoading = true);
                                ref
                                    .read(userProvider.notifier)
                                    .requestResetPassword(_userNameController.text)
                                    .then((e) {
                                  setState(() => isLoading = false);

                                  Navigator.of(context)
                                      .pushReplacementNamed(AppRoutes.initialRoute);
                                  Utilitis.showSnackBar(
                                      context,
                                      e
                                          ? 'Support wurde kontaktiert'
                                          : 'Leider ist bei der Anfrage etwas schief gegangen');
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                shape:
                                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                backgroundColor: const Color.fromARGB(255, 224, 142, 60),
                                padding: const EdgeInsets.all(10),
                                fixedSize: const Size.fromHeight(40),
                              ),
                              child: Center(
                                child: isLoading
                                    ? const CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                      )
                                    : const Text(
                                        'Admin kontaktieren',
                                        style: TextStyle(color: Colors.white),
                                      ),
                              ),
                            )),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
