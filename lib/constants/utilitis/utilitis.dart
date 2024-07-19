// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:ui_web' as ui;

import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdf_widget;

import '../../view/shared_widgets/time_spinner.dart';
import '../themes/app_color.dart';

class Utilitis {
  static Future<String?> showTimeSpinner(BuildContext context, DateTime initalTime) async {
    final result = await showDialog(
      context: context,
      builder: (context) => Center(
        child: Container(
            height: MediaQuery.of(context).size.height - 150,
            margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.3,
              vertical: MediaQuery.of(context).size.height * 0.2,
            ),
            child: TimeSpinnerWidget(initalTime: initalTime)),
      ),
    );
    if (result.runtimeType != String) {
      return null;
    }
    return result;
  }

  static HeaderStyle buildCustomHeadStyle(BuildContext context) => HeaderStyle(
        leftIcon: Container(
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 6),
          child: const Icon(
            Icons.arrow_left_outlined,
            size: 45,
            color: AppColor.kPrimaryButtonColor,
          ),
        ),
        rightIcon: Container(
          padding: const EdgeInsets.symmetric(vertical: 6),
          alignment: Alignment.centerLeft,
          child: const Row(
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

  static Color getStatusColor(String? status) => switch (status) {
        ('Abgeschlossen') => AppColor.kGreen,
        ('Gestartet') => AppColor.kPrimaryButtonColor,
        ('Pausiert') => AppColor.kRed,
        ('Geplant') => AppColor.kYellow,
        (_) => Colors.black
      };

  static String getWeekDayStringShort(int weekday) => switch (weekday) {
        1 => 'MO',
        2 => 'DI',
        3 => 'MI',
        4 => 'DO',
        5 => 'FR',
        6 => 'SA',
        7 => 'SO',
        _ => throw Exception('There was a unkown Weekday maybe😅')
      };
  static String getWeekDayStringLong(int weekday) => switch (weekday) {
        1 => 'Montag',
        2 => 'Dienstag',
        3 => 'Mittwoch',
        4 => 'Donnerstag',
        5 => 'Freitag',
        6 => 'Samstag',
        7 => 'Sonntag',
        _ => throw Exception('There was a unkown Weekday maybe😅')
      };

  static void showSnackBar(
    BuildContext context,
    String message, [
    bool showCloseIcon = false,
    Duration duration = const Duration(seconds: 7),
    SnackBarBehavior behavior = SnackBarBehavior.floating,
  ]) {
    final snackBar = SnackBar(
      showCloseIcon: showCloseIcon,
      content: Center(child: Text(message, textAlign: TextAlign.center)),
      duration: duration,
      behavior: behavior,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static InputDecoration textFieldDecoration([String? hintText, Icon? suffixIcon]) =>
      InputDecoration(
        filled: true,
        fillColor: AppColor.kTextfieldColor,
        hintText: hintText,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey, width: 0),
          borderRadius: BorderRadius.circular(6),
        ),
        suffixIcon: suffixIcon,
      );

  static void writePDFAndDownload(Map<String, dynamic> newUser) async {
    final byteList = await _createPDF(newUser);
    final file = XFile.fromData(byteList);
    html.AnchorElement anchorE = html.AnchorElement(href: ui.AssetManager().getAssetUrl(file.path));
    anchorE.download = "AnmeldeDaten ${newUser['userName']}.pdf";
    anchorE.click();
  }

  /// This private Method create the Layout for the Pdf with the intinal User data.
  /// Call this method with a [Map] with [Key] 'userName' and [Key] password.
  /// return a [Future] ByteList.
  static Future<Uint8List> _createPDF(Map<String, dynamic> newUser) async {
    final pdf = pdf_widget.Document(
        version: PdfVersion.pdf_1_4, compress: true, title: 'Anmeldedaten: ${newUser['userName']}');
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
                  pdf_widget.SizedBox(
                    width: 300,
                    child: pdf_widget.Text('Generiertes Passwort: '),
                  ),
                  pdf_widget.SizedBox(height: 8),
                  pdf_widget.SizedBox(
                    width: 300,
                    child: pdf_widget.Text('${newUser['password']}'),
                  ),
                ],
              ),
            )),
      ),
    );
    return pdf.save();
  }

  /// Split the [String] values from the TextEdingController with the given
  /// format and build [DateTime] objects with the Compination from
  /// _dayPickerController and _startController.
  /// than do  the same translation with _dayPickerController and _endController
  /// and return the different between this [DateTime] object in minutes.

  static String buildDurationInHourers(int? duration) {
    if (duration == null) return '0 min.';
    final hours = duration ~/ 60;

    final minutes = duration % 60;
    // TODO: exclude pause?
    return '$hours:${minutes < 10 ? '0$minutes' : minutes} h.';
  }
}
