import 'package:flutter/material.dart';
import 'package:handwerker_web/routes/app_routes.dart';
import 'package:handwerker_web/view/view_widgets/background_widget.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isFocused = false;
  bool isOTP = false;
  TextEditingController emailCon = TextEditingController();
  TextEditingController passCon = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
          body: Padding(
            padding: const EdgeInsets.only(top: 60, left: 40, right: 40),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                    child: Image.asset(
                      'assets/images/img_techtool.png',
                    ),
                  ),
                  const SizedBox(
                    height: 9,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Anmelden",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(color: const Color.fromARGB(192, 255, 255, 255)),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Form(
                    key: formstate,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Nutzername",
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: const Color.fromARGB(192, 255, 255, 255),
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 3,
                        ),

                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: const Color.fromARGB(192, 255, 255, 255),
                          ),
                          child: Focus(
                            onFocusChange: (hasFocus) {
                              setState(() {
                                isFocused = hasFocus;
                              });
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              height: isFocused ? 40 : 35,
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                validator: (value) => value!.length < 6 ? "Required" : null,
                                // obscureText: widget.isPass ? obscure : false,
                                controller: emailCon,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.transparent,
                                  // suffixIcon: widget.isPass
                                  //     ? IconButton(
                                  //         onPressed: () {
                                  //           setState(() {
                                  //             obscure = !obscure;
                                  //           });
                                  //         },
                                  //         icon: const Icon(Icons.remove_red_eye))
                                  //     : const SizedBox(),
                                  contentPadding: const EdgeInsets.all(6),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color: const Color.fromARGB(255, 224, 142, 60),
                                      )),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: isFocused
                                          ? const Color.fromARGB(255, 224, 142, 60)
                                          : Colors.transparent,
                                    ),
                                  ),
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
                        Text(
                          "Passwort",
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: const Color.fromARGB(192, 255, 255, 255),
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: const Color.fromARGB(192, 255, 255, 255),
                          ),
                          child: Focus(
                            onFocusChange: (hasFocus) {
                              setState(() {
                                isFocused = hasFocus;
                              });
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              height: isFocused ? 40 : 35,
                              child: TextFormField(
                                //   controller: passCon,
                                //   isPass: true,
                                textInputAction: TextInputAction.next,
                                validator: (value) => value!.length < 6 ? "Required" : null,
                                // obscureText: widget.isPass ? obscure : false,
                                controller: passCon,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.transparent,
                                  // suffixIcon: widget.isPass
                                  //     ? IconButton(
                                  //         onPressed: () {
                                  //           setState(() {
                                  //             obscure = !obscure;
                                  //           });
                                  //         },
                                  //         icon: const Icon(Icons.remove_red_eye))
                                  //     : const SizedBox(),
                                  contentPadding: const EdgeInsets.all(6),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        const BorderSide(color: Color.fromARGB(255, 224, 142, 60)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: isFocused
                                          ? const Color.fromARGB(255, 224, 142, 60)
                                          : Colors.transparent,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Switch(
                            value: isOTP,
                            onChanged: (value) {
                              setState(() {
                                isOTP = value;
                              });
                            },
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: GestureDetector(
                              child: Text(
                                "Passwort vergessen?",
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                              ),
                              onTap: () {
                                Navigator.of(context).pushNamed(AppRoutes.forgotPassword);
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: SizedBox(
                            width: 235,
                            height: 35,
                            child: ElevatedButton(
                              onPressed: () {
                                if (formstate.currentState!.validate()) {
                                  print("valid");
                                } else {
                                  print("Not Valid");
                                }
                                if (isOTP) {
                                  Navigator.of(context).pushNamed(AppRoutes.setPasswordScreen);
                                } else {
                                  Navigator.of(context).pushReplacementNamed(AppRoutes.viewScreen);
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
                                  "Anmelden",
                                  style: TextStyle(color: Colors.white),
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
          imageName: 'img_anmelden.png'),
    );
  }
}
