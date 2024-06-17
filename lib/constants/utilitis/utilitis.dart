// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:typed_data';
import 'dart:ui_web' as ui;

import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdf_widget;

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
    final byteList = await _createPDF(newUser);
    final file = XFile.fromData(byteList);
    html.AnchorElement anchorE = html.AnchorElement(href: ui.AssetManager().getAssetUrl(file.path));
    anchorE.download = "AnmeldeDaten ${newUser['userName']}.pdf";
    anchorE.click();
  }

  static HeaderStyle buildCustomHeadStyle(BuildContext context) => HeaderStyle(
        leftIcon: Container(
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
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(60.0),
              child: Text(
                message,
                textAlign: TextAlign.center,
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

  static InputDecoration textFieldDecoration(String hintText) => InputDecoration(
        filled: true,
        fillColor: AppColor.kTextfieldColor,
        hintText: hintText,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey, width: 0),
          borderRadius: BorderRadius.circular(6),
        ),
      );

  static Color getStatusColor(String? status) => switch (status) {
        ('Abgeschlossen') => AppColor.kGreen,
        ('Gestartet') => AppColor.kPrimaryButtonColor,
        ('Pausiert') => AppColor.kRed,
        ('Geplant') => AppColor.kYellow,
        (_) => Colors.black
      };

  /// This private Method create the Layout for the Pdf with the intinal User data.
  /// Call this method with a [Map] with [Key] 'userName' and [Key] password.
  /// return a [Future] ByteList.
  static Future<Uint8List> _createPDF(Map<String, dynamic> newUser) async {
    final pdf = pdf_widget.Document(version: PdfVersion.pdf_1_4, compress: true);
    final image = pdf_widget.Image(
        pdf_widget.MemoryImage(
            (await rootBundle.load('assets/images/img_techtool.png')).buffer.asUint8List()),
        height: 20);
    pdf.addPage(
      pdf_widget.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) => pdf_widget.SizedBox(
            width: double.infinity,
            child: pdf_widget.FittedBox(
              child: pdf_widget.Column(
                children: [
                  // pdf_widget.Header(title: 'Techtool'),
                  pdf_widget.Container(
                    alignment: pdf_widget.Alignment.centerRight,
                    width: 300,
                    child: image,
                  ),
                  pdf_widget.SizedBox(height: 8),
                  pdf_widget.Container(
                    width: 300,
                    height: 1.5,
                    margin: const pdf_widget.EdgeInsets.symmetric(vertical: 5),
                    color: PdfColors.black,
                  ),
                  pdf_widget.SizedBox(
                    width: 300,
                    child: pdf_widget.Text('Anmeldedaten für den neuen Nutzer:'),
                  ),
                  pdf_widget.SizedBox(height: 8),
                  pdf_widget.SizedBox(
                    width: 300,
                    child: pdf_widget.Text('${newUser['userName']}'),
                  ),
                  pdf_widget.SizedBox(height: 8),
                  // // Nutzername: ${newUser['userName']}\n
                  pdf_widget.SizedBox(
                    width: 300,
                    child: pdf_widget.Text('Generiertes Passwort: '),
                  ),
                  pdf_widget.SizedBox(height: 8),
                  pdf_widget.SizedBox(
                    width: 300,
                    child: pdf_widget.Text('${newUser['password']}'),
                  ),

                  // pw.Container(child:pw.Align(alignment: ) ,)
                ],
              ),
            )),
      ),
    );
    return pdf.save();
  }
}
