// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:ui_web' as ui;
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../view/shared_widgets/symetric_button_widget.dart';
import '../themes/app_color.dart';

class Utilitis {
  static String getWeekDayString(int weekday) => switch (weekday) {
        1 => 'MO',
        2 => 'DI',
        3 => 'MI',
        4 => 'Do',
        5 => 'Fr',
        6 => 'Sa',
        7 => 'So',
        _ => throw Exception('There was a unkown Weekday maybe😅')
      };

  static void writePDFAndDownload(Map<String, dynamic> newUser) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (context) => pw.Column(
          children: [
            pw.Header(title: 'Techtool'),
            pw.SizedBox(height: 8),
            pw.Text('Anmeldedaten für den neuen Nutzer:'),
            pw.SizedBox(height: 8),
            pw.Text('${newUser['userName']}'),
            pw.SizedBox(height: 8),
            // Nutzername: ${newUser['userName']}\n
            pw.Text('Generiertes Passwort: '),
            pw.SizedBox(height: 8),
            pw.Text('${newUser['password']}'),

            // pw.Container(child:pw.Align(alignment: ) ,)
          ],
        ),
      ),
    );
    final XFile file = XFile.fromData(await pdf.save());
    html.AnchorElement anchorElement =
        html.AnchorElement(href: ui.AssetManager().getAssetUrl(file.path));
    anchorElement.download = "AnmeldeDaten ${newUser['userName']}.pdf";
    anchorElement.click();
  }

  static HeaderStyle buildCustomHeadStyle(BuildContext context) => HeaderStyle(
        leftIcon: Container(
          // width: MediaQuery.of(context).size.width * 0.31,
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 6),
          child: Icon(
            Icons.arrow_left_outlined,
            size: 45,
            color: AppColor.kPrimaryButtonColor,
          ),
        ),
        rightIcon: Container(
          padding: const EdgeInsets.symmetric(vertical: 6),
          alignment: Alignment.centerLeft,
          // width: MediaQuery.of(context).size.width * 0.31,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.arrow_right_outlined,
                size: 45,
                color: AppColor.kPrimaryButtonColor,
              ),
            ],
          ),
        ),
        headerTextStyle: Theme.of(context).textTheme.titleLarge,
        decoration: const BoxDecoration(color: Colors.white),
      );

  static Widget waitingMessage(BuildContext context, String message) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                message,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            const CircularProgressIndicator(),
          ],
        ),
      );

  static Future<dynamic> askPopUp(
    BuildContext context, {
    required String message,
    required Function() onAccept,
    required Function() onReject,
  }) =>
      showDialog(
        context: context,
        barrierColor: const Color.fromARGB(20, 0, 0, 0),
        builder: (context) => Dialog(
          backgroundColor: Colors.white,
          child: SizedBox(
            // decoration: BoxDecoration(
            // border: Border.all(color: AppColor.kTextfieldBorder, width: 1.5),
            // borderRadius: BorderRadius.circular(30)),
            height: 350,
            width: MediaQuery.of(context).size.width / 10 * 60,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        message,
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40.0),
                            child: SymmetricButton(
                              text: 'Ja',
                              onPressed: onAccept,
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40.0),
                            child: SymmetricButton(
                              text: 'Nein',
                              onPressed: onReject,
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            ),
                          ),
                        ],
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
