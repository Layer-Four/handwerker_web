import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ForgetScreen extends ConsumerStatefulWidget {
  const ForgetScreen({super.key});

  @override
  ConsumerState<ForgetScreen> createState() => _ForgetScreenState();
}

class _ForgetScreenState extends ConsumerState<ForgetScreen> {
  final TextEditingController _userNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    bool obscure = true;
    // bool isFocused = false;
    return Material(
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                  child: Image.asset(
                    'assets/images/img_techtool.png',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "bitte benachrichtige den Adminstrator",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                // !start Textformfield
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.black, width: 2), // Add border here
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color.fromARGB(192, 255, 255, 255),
                    ),
                    child: Focus(
                      onFocusChange: (hasFocus) {
                        setState(() {
                          // isFocused = hasFocus;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        height:
                            //  isFocused ? 40 :
                            35,
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          validator: (value) => value!.length < 6 ? "Required" : null,
                          obscureText: obscure,
                          controller: _userNameController,
                          decoration: InputDecoration(
                            hintText: 'Nutzername',
                            hintStyle: const TextStyle(color: Colors.grey),
                            filled: true,
                            fillColor: Colors.transparent,
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    obscure = !obscure;
                                  });
                                },
                                icon: const Icon(Icons.remove_red_eye)),
                            contentPadding: const EdgeInsets.all(6),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  const BorderSide(color: Color.fromARGB(255, 224, 142, 60)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color:
                                    // isFocused
                                    // ? const Color.fromARGB(255, 224, 142, 60)                                    :
                                    Colors.transparent,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // child: UserAndPasswordField(
                  //   hintText: 'Nutzername',
                  //   controller: emailCon,
                  // ),
                ),
                // !end Textrformfield
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    backgroundColor: const Color.fromARGB(255, 224, 142, 60),
                    padding: const EdgeInsets.all(10),
                  ),
                  child: Center(
                    child: Text(
                      "Senden".toUpperCase(),
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
