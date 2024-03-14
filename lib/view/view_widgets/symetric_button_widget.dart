import 'package:flutter/material.dart';

class SymmetricButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final Color color;
  final EdgeInsets padding;
  final TextStyle style;
  const SymmetricButton({
    super.key,
    this.onPressed,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    this.style = const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
    required this.color,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      color: color,
      borderRadius: BorderRadius.circular(11),
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
              textAlign: TextAlign.center,
              style: style,
            ),
          ),
        ),
      ),
    );
  }
}
