import 'package:flutter/material.dart';

class SymmetricButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final Color? color;
  final EdgeInsets padding;
  final TextStyle? style;
  final TextOverflow? overflow;
  final double elevation;
  final BorderRadius? borderRadius;
  const SymmetricButton({
    color,
    super.key,
    this.onPressed,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    this.borderRadius,
    this.elevation = 5,
    this.overflow,
    style,
    required this.text,
  })  : style = style ?? const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        color = color ?? const Color.fromARGB(255, 224, 142, 60);

  @override
  Widget build(BuildContext context) => Material(
        elevation: elevation,
        color: color,
        borderRadius: borderRadius ?? BorderRadius.circular(11),
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
                style: style,
              ),
            ),
          ),
        ),
      );
}
