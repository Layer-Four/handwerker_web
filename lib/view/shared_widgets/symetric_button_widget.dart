import 'package:flutter/material.dart';

import '../../constants/themes/app_color.dart';

class SymmetricButton extends StatefulWidget {
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
  State<SymmetricButton> createState() => _SymmetricButtonState();
}

class _SymmetricButtonState extends State<SymmetricButton> with SingleTickerProviderStateMixin {
  static const clickAnimationDurationMillis = 100;

  double _scaleTransformValue = 1;

  // needed for the "click" tap effect
  late final AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: clickAnimationDurationMillis),
      lowerBound: 0.0,
      upperBound: 0.05,
    )..addListener(() {
        setState(() => _scaleTransformValue = 1 - animationController.value);
      });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void _shrinkButtonSize() {
    animationController.forward();
  }

  void _restoreButtonSize() {
    Future.delayed(
      const Duration(milliseconds: clickAnimationDurationMillis),
      () => animationController.reverse(),
    );
  }

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () {
          widget.onPressed?.call();
          // _shrinkButtonSize();
          // _restoreButtonSize();
        },
        onTapDown: (_) => _shrinkButtonSize(),
        onTapUp: (_) => _restoreButtonSize(),
        child: Transform.scale(
          scale: _scaleTransformValue,
          child: Material(
            elevation: widget.elevation,
            color: widget.color ?? AppColor.kPrimaryButtonColor,
            borderRadius: widget.borderRadius ?? BorderRadius.circular(6),
            type: MaterialType.card,
            child: Center(
              widthFactor: 1.5,
              heightFactor: 1.2,
              child: Padding(
                padding: widget.padding,
                child: Text(
                  widget.text,
                  overflow: widget.overflow,
                  textAlign: TextAlign.center,
                  style: widget.textStyle ??
                      Theme.of(context).textTheme.labelMedium?.copyWith(color: AppColor.kWhite),
                ),
              ),
            ),
          ),
        ),
      );
}
