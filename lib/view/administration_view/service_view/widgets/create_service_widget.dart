import 'package:flutter/material.dart';

import '../../../../constants/themes/app_color.dart';
import '../../../shared_widgets/symetric_button_widget.dart';

class CreateServiceWidget extends StatefulWidget {
  final Function() onSave;
  final Function onReject;

  const CreateServiceWidget({
    required this.onSave,
    required this.onReject,
    super.key,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CardWidgetState createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CreateServiceWidget> {
  final TextEditingController _leistungController = TextEditingController();
  final TextEditingController _preisController = TextEditingController();

  @override
  void dispose() {
    _leistungController.dispose();
    _preisController.dispose();
    super.dispose();
  }

  // void createService() async {
  //   final String leistung = _leistungController.text.trim();
  //   final String preis = _preisController.text.trim();

  //   if (leistung.isEmpty || preis.isEmpty) {f
  //     showDialog(
  //       context: context,
  //       builder: (ctx) => AlertDialog(
  //         title: const Text('Fehler'),
  //         content: const Text('Alle Felder müssen ausgefüllt sein!'),
  //         actions: <Widget>[
  //           TextButton(
  //             child: const Text('Ok'),
  //             onPressed: () {
  //               Navigator.of(ctx).pop();
  //             },
  //           ),
  //         ],
  //       ),
  //     );
  //     return;
  //   }

  //   try {
  //     setState(() {
  //       _isLoading = true;
  //     });
  //     final response = await http.post(
  //       Uri.parse('https://r-wa-happ-be.azurewebsites.net/api/service/create'),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json',
  //       },
  //       body: jsonEncode(<String, String>{
  //         'name': leistung,
  //         'hourlyRate': preis,
  //       }),
  //     );

  //     if (response.statusCode == 200) {
  //       widget.onSave(leistung, preis);

  //       if (Navigator.canPop(context)) {
  //         Navigator.of(context).pop(); // Only pop if there's a stack to pop from.
  //       }
  //     } else {
  //       throw Exception('Failed to create service.');
  //     }
  //   } catch (e) {
  //     showDialog(
  //       context: context,
  //       builder: (ctx) => AlertDialog(
  //         title: const Text('Fehler beim Speichern'),
  //         content: Text('Ein Fehler ist aufgetreten: $e'),
  //         actions: <Widget>[
  //           TextButton(
  //             child: const Text('Ok'),
  //             onPressed: () {
  //               Navigator.of(ctx).pop();
  //             },
  //           ),
  //         ],
  //       ),
  //     );
  //   } finally {
  //     setState(() {
  //       _isLoading = false; // Stop loading after the API call completes
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) => SizedBox(
        width: MediaQuery.of(context).size.width > 1000
            ? 800
            : MediaQuery.of(context).size.width / 10 * 9,
        child: Card(
          surfaceTintColor: Colors.white,
          elevation: 6,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width > 1000
                          ? 200
                          : MediaQuery.of(context).size.width / 10 * 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Leistung',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.bold)),
                          TextField(
                            controller: _leistungController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color.fromARGB(211, 245, 241, 241),
                              hintText: 'Leistung',
                              contentPadding: const EdgeInsets.all(10),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.grey, width: 0),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width > 1000
                          ? 200
                          : MediaQuery.of(context).size.width / 10 * 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Preis/std', style: TextStyle(fontWeight: FontWeight.bold)),
                          TextField(
                            controller: _preisController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color.fromARGB(211, 245, 241, 241),
                              hintText: 'Preis/std',
                              contentPadding: const EdgeInsets.all(10),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.grey, width: 0),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 12),
                        child: SymmetricButton(
                          text: 'Verwerfen',
                          textStyle: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: AppColor.kPrimaryButtonColor),
                          color: AppColor.kWhite,
                          onPressed: () {
                            _leistungController.clear();
                            _preisController.clear();
                            widget.onReject();
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 12.0),
                        child: SymmetricButton(
                          text: 'Speichern',
                          textStyle: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: AppColor.kWhite),
                          onPressed: () {
                            final leistung = _leistungController.text;
                            final preis = _preisController.text;
                            if (leistung.isNotEmpty && preis.isNotEmpty) {
                              if (true) {}
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Fehlende Informationen'),
                                  content: const Text('Bitte füllen Sie alle Felder aus.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
