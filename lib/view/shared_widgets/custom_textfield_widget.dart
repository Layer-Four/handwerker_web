import 'package:flutter/material.dart';

import '../../constants/utilitis/utilitis.dart';

class CustomTextfield extends StatelessWidget {
  final TextEditingController controller;
  final InputDecoration? decoration;
  final String? hintText;
  final double? textfieldHeight;

  ///  If A title is given than show Text Widget with Padding.
  final String? title;

  ///  When Custom TextStyle is given than override Default TextTheme.
  final TextStyle? titleStyle;

  /// Change Default dynamic height of the whole Widget.
  final double? widgetHeight;

  /// Change Default dynamic width of the whole Widget.
  final double? widgetWidth;

  /// In default set MaxLine parameter to 1 when set true is set maxLine to null.
  /// this make the textfield multiline accectable.
  final bool isMultiLine;

  const CustomTextfield({
    super.key,
    required this.controller,
    this.decoration,
    this.hintText,
    this.isMultiLine = false,
    this.title,
    this.textfieldHeight,
    this.titleStyle,
    this.widgetHeight,
    this.widgetWidth,
  });
  @override
  Widget build(BuildContext context) => SizedBox(
        width:
            widgetWidth ?? (MediaQuery.of(context).size.width > 950 ? 300 : MediaQuery.of(context).size.width * 0.35),
        height: widgetHeight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            title != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      title!,
                      style:
                          titleStyle ?? Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                    ),
                  )
                : const SizedBox.shrink(),
            SizedBox(
              height: textfieldHeight,
              child: TextField(
                expands: textfieldHeight == null ? false : true,
                controller: controller,
                maxLines: isMultiLine ? null : 1,
                decoration: decoration ?? Utilitis.textFieldDecoration(hintText),
              ),
            ),
          ],
        ),
      );
}
