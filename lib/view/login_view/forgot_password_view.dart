import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ForgetScreen extends ConsumerStatefulWidget {
  const ForgetScreen({super.key});

  @override
  ConsumerState<ForgetScreen> createState() => _ForgetScreenState();
}

class _ForgetScreenState extends ConsumerState<ForgetScreen> {
  final TextEditingController _userNameController = TextEditingController();
  bool obscureText = true;

  @override
  Widget build(BuildContext context) => Material(
        child: Scaffold(
          appBar: AppBar(),
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
                            child: const Text(
                              'Passwort zurücksetzen',
                              style: TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.w700,
                                // decoration: TextDecoration.underline,
                                decorationColor: Colors.orange,
                                decorationThickness: 2.0,
                              ),
                            ),
                            onTap: () {
                              // Navigator.of(context).pushNamed(AppRoutes.forgotPassword);
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      const SizedBox(
                        width: 355,
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            'Mandantennamme',
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
                            setState(() {
                              // Use this to update UI on focus changes if needed
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            height: 40,
                            child: TextFormField(
                              textInputAction: TextInputAction.next,
                              validator: (value) =>
                                  value!.length < 6 ? 'Required' : null,
                              obscureText: !obscureText,
                              controller: _userNameController,
                              decoration: const InputDecoration(
                                // hintStyle: const TextStyle(color: Colors.grey),
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
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          backgroundColor:
                              const Color.fromARGB(255, 224, 142, 60),
                          padding: const EdgeInsets.all(10),
                          fixedSize: const Size.fromHeight(40),
                        ),
                        child: const Center(
                          child: Text(
                            'Layer Four kontaktieren',
                            style: TextStyle(color: Colors.white),
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
