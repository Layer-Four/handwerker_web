// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:ui_web' as ui;
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf/widgets.dart' as pw;

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
}
