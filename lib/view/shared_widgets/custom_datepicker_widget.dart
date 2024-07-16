import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../constants/utilitis/utilitis.dart';

class CustomDatePicker extends StatelessWidget {
  final TextEditingController controller;
  final DateTime initDate;
  final String? hintText;
  final EdgeInsets? padding;
  final double? width;
  final double? height;
  final String? title;
  final TextStyle? titleStyle;
  const CustomDatePicker({
    super.key,
    required this.controller,
    required this.initDate,
    this.height,
    this.hintText,
    this.padding,
    this.title,
    this.titleStyle,
    this.width,
  });
  @override
  Widget build(BuildContext context) => SizedBox(
        width: width ??
            (MediaQuery.of(context).size.width > 950
                ? 300
                : MediaQuery.of(context).size.width * 0.35),
        height: height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title == null
                ? const SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      title!,
                      style: titleStyle ??
                          Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
            Container(
              padding: padding,
              child: TextField(
                controller: controller,
                decoration:
                    Utilitis.textFieldDecoration(hintText, const Icon(Icons.calendar_today)),
                readOnly: true,
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    firstDate: DateTime.now().add(const Duration(days: -1825)),
                    initialDate: initDate,
                    lastDate: DateTime.now().add(const Duration(days: 3650)),
                  );
                  if (date != null) {
                    controller.text = DateFormat('d.M.y').format(date);
                  }
                  return;
                },
              ),
            ),
          ],
        ),
      );
}
