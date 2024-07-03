// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:ui_web' as ui;

import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdf_widget;

import '../../view/shared_widgets/symetric_button_widget.dart';
import '../../view/time_entry_view/widgets/time_spinner.dart';
import '../themes/app_color.dart';

class Utilitis {
  static Future<String?> showTimeSpinner(BuildContext context, DateTime initalTime) async {
    final result = await showDialog(
      context: context,
      builder: (context) => Container(
          margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.3,
            vertical: MediaQuery.of(context).size.height * 0.2,
          ),
          child: TimeSpinnerWidget(initalTime: initalTime)),
    );
    if (result.runtimeType != String) {
      return null;
    }
    return result;
  }

  static void showErrorMessage(BuildContext context, String errorMessage) => showDialog(
        context: context,
        builder: (context) => GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: AlertDialog(
            backgroundColor: Colors.white,
            content: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 24),
              child: Text(errorMessage),
            ),
          ),
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

  static Color getStatusColor(String? status) => switch (status) {
        ('Abgeschlossen') => AppColor.kGreen,
        ('Gestartet') => AppColor.kPrimaryButtonColor,
        ('Pausiert') => AppColor.kRed,
        ('Geplant') => AppColor.kYellow,
        (_) => Colors.black
      };

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

  static Future<dynamic> showNewPasswordPopUp(
    BuildContext context,
    Map<String, dynamic> e, {
    Function()? onAccept,
    String? onAcceptTitel,
  }) =>
      showDialog(
        context: context,
        builder: (context) => Dialog(
          backgroundColor: Colors.white,
          child: SizedBox(
            height: 400,
            width: 400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        'Mitarbeiter:',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          '   ${e['userName']}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    children: [
                      Text(
                        'Passwort:',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          '     ${e['password']}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                        child: SymmetricButton(
                          text: 'Als PDF Herunterladen',
                          onPressed: () => writePDFAndDownload(e),
                        ),
                      ),
                      onAccept == null
                          ? const SizedBox.shrink()
                          : Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                              child: SymmetricButton(
                                text: onAcceptTitel ?? '',
                                onPressed: onAccept,
                              ),
                            )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  static void showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Center(child: Text(message, textAlign: TextAlign.center)),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

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
