import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../constants/themes/app_color.dart';

class HoverTextfieldWidget extends StatefulWidget {
  /// The required TextEditingController to update the value in GUI
  final TextEditingController _controller;

  /// a required bool set readOnly
  final bool _isEdit;

  final void Function()? onDoubleTap;
  final void Function(PointerDownEvent)? onTapOutside;
  final void Function(String)? onSubmitted;
  final void Function(String)? onChanged;
  final List<TextInputFormatter>? format;
  final TextInputAction? inputAction;
  final TextInputType? keyboardType;
  final FocusNode? focus;

  ///  give a double for width on big displays in default[200],
  /// like MediaQuery.of(context).size.width > 950 than use onMaxWidth
  /// for max Widget Width
  final double? onMaxWidth;

  ///  give a double for width on small displays in default[0.18],
  /// like MediaQuery.of(context).size.width < 950 than use onMinWidth
  /// the double is a percentes in decimal like 0.10 for 10%
  final double? minWidth;

  const HoverTextfieldWidget({
    super.key,
    required TextEditingController controller,
    required bool isEdit,
    this.focus,
    this.format,
    this.inputAction,
    this.keyboardType,
    this.onDoubleTap,
    this.onChanged,
    this.onMaxWidth,
    this.minWidth,
    this.onSubmitted,
    this.onTapOutside,
  })  : _controller = controller,
        _isEdit = isEdit;

  @override
  State<HoverTextfieldWidget> createState() => _HoverTextfieldWidgetState();
}

class _HoverTextfieldWidgetState extends State<HoverTextfieldWidget> {
  bool _isHover = false;
  Color getBorderColor(bool isHovered) => isHovered ? AppColor.kPrimary : Colors.white;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onDoubleTap: widget.onDoubleTap,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          width: MediaQuery.of(context).size.width > 950
              ? widget.onMaxWidth ?? 184
              : (MediaQuery.of(context).size.width * (widget.minWidth ?? 0.18)) - 16,
          child: MouseRegion(
            onEnter: (_) => setState(() => _isHover = true),
            onExit: (_) => setState(() => _isHover = false),
            child: Container(
              decoration: BoxDecoration(
                color: widget._isEdit ? Colors.grey[200] : null,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: _isHover
                      ? AppColor.kPrimaryButtonColor
                      : widget._isEdit
                          ? AppColor.kPrimary
                          : AppColor.kWhite,
                ),
              ),
              child: TextField(
                controller: widget._controller,
                style: Theme.of(context).textTheme.titleMedium,
                readOnly: !widget._isEdit,
                keyboardType: widget.keyboardType,
                textInputAction: widget.inputAction,
                inputFormatters: widget.format,
                focusNode: widget.focus,
                onTapOutside: widget.onTapOutside,
                onSubmitted: widget.onSubmitted,
                onChanged: widget.onChanged,
                decoration: const InputDecoration(
                  border:
                      // widget._isEdit ? OutlineInputBorder(borderSide: BorderSide(color: AppColor.kPrimaryButtonColor)):
                      InputBorder.none,
                  contentPadding: EdgeInsets.all(6),
                ),
              ),
            ),
          ),
        ),
      );
}
