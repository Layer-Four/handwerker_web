import 'package:flutter/material.dart';

import '../../constants/themes/app_color.dart';

class CustomDropDown<T> extends StatelessWidget {
  final Color borderColor;
  final double borderRadius;
  final Color? color;
  final List<DropdownMenuItem<T>>? items;
  final double? height;
  final T? initalValue;
  final String? hintText;
  final bool isExpanded;
  final void Function(T?) onChanged;
  final EdgeInsets padding;
  final String? title;
  final TextStyle? titleStyle;
  final Widget underline;
  final double? width;
  // final BorderRadius borderRadius;
  const CustomDropDown({
    super.key,
    required this.items,
    required this.onChanged,
    this.borderColor = Colors.white,
    this.borderRadius = 6.0,
    this.color,
    this.isExpanded = true,
    this.initalValue,
    this.height,
    this.hintText,
    this.underline = const SizedBox.shrink(),
    this.padding = const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
    this.title,
    this.titleStyle,
    this.width,
  });
  @override
  Widget build(context) => SizedBox(
        width: width ??
            (MediaQuery.of(context).size.width > 950
                ? 300
                : MediaQuery.of(context).size.width * 0.35),
        height: height,
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
              height: 48,
              decoration: BoxDecoration(
                color: color ?? AppColor.kTextfieldColor,
                borderRadius: BorderRadius.circular(borderRadius),
                border: Border.all(color: borderColor),
              ),
              child: DropdownButton<T>(
                value: initalValue,
                hint: Text(hintText ?? ''),
                underline: underline,
                isExpanded: isExpanded,
                items: items,
                onChanged: onChanged,
              ),
            ),
          ],
        ),
      );
}
