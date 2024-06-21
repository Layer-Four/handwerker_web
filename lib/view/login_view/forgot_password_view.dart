import 'dart:convert'; // For JSON operations
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../constants/themes/app_color.dart';

class ForgetScreen extends ConsumerStatefulWidget {
  const ForgetScreen({super.key});

  @override
  ConsumerState<ForgetScreen> createState() => _ForgetScreenState();
}

class _ForgetScreenState extends ConsumerState<ForgetScreen> {
  final TextEditingController _userNameController = TextEditingController();
  bool obscureText = true;
  bool isLoading = false;

  Future<void> resetPassword() async {
    setState(() {
      isLoading = true;
    });

    final String username = _userNameController.text.trim();
    const int mandantId = 1;

    if (username.isEmpty) {
      _showSnackBar('Bitte einen Mandantennamen eingeben.');
      setState(() {
        isLoading = false;
      });
      return;
    }

    if (username.length < 3) {
      _showSnackBar('Der Benutzername muss mindestens 3 Zeichen lang sein.');
      setState(() {
        isLoading = false;
      });
      return;
    }

    final url = Uri.parse('https://r-wa-happ-be.azurewebsites.net/api/user/password/request');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'MandantID': mandantId, 'userName': username});

    try {
      final response = await http.post(url, headers: headers, body: body);

      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        if (responseData.containsKey('id')) {
          if (responseData['userName'] == username.toLowerCase()) {
            _showSnackBar('Passwort-Reset-Anfrage erfolgreich gesendet.');
          } else {
            _showSnackBar('Benutzername stimmt nicht überein.');
          }
        } else {
          _showSnackBar(
              'Fehler beim Senden der Passwort-Reset-Anfrage. ${responseData['message'] ?? 'Bitte versuchen Sie es erneut.'}');
        }
      } else {
        _showSnackBar(
            'Fehler beim Senden der Passwort-Reset-Anfrage. Statuscode: ${response.statusCode}');
      }
    } catch (e) {
      _showSnackBar('Fehler beim Senden der Anfrage: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _showSnackBar(String message) {
    final snackBar = SnackBar(content: Center(child: Text(message)));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

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
                            setState(() {});
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            height: 40,
                            child: TextFormField(
                              textInputAction: TextInputAction.next,
                              validator: (value) => value!.length < 6 ? 'Required' : null,
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
                      ElevatedButton(
                        onPressed: isLoading ? null : resetPassword,
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
