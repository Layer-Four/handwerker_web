import 'package:flutter/material.dart';

import '../../constants/themes/app_color.dart';

class SymmetricButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final Color? color;
  final EdgeInsets padding;
  final TextStyle? textStyle;
  final TextOverflow? overflow;
  final double elevation;
  final BorderRadius? borderRadius;
  const SymmetricButton({
    this.color,
    super.key,
    this.onPressed,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    this.borderRadius,
    this.elevation = 5,
    this.overflow = TextOverflow.clip,
    this.textStyle,
    required this.text,
  });

  @override
  Widget build(BuildContext context) => Material(
        elevation: elevation,
        color: color ?? AppColor.kPrimaryButtonColor,
        borderRadius: borderRadius ?? BorderRadius.circular(6),
        type: MaterialType.card,
        child: InkWell(
          onTap: onPressed,
          child: Center(
            widthFactor: 1.5,
            heightFactor: 1.2,
            child: Padding(
              padding: padding,
              child: Text(
                text,
                overflow: overflow,
                textAlign: TextAlign.center,
                style: textStyle ??
                    Theme.of(context).textTheme.labelMedium?.copyWith(color: AppColor.kWhite),
              ),
            ),
          ),
        ),
      );
}
