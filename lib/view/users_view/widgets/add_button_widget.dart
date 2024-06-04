import 'package:flutter/material.dart';

import '../../../constants/themes/app_color.dart';

class AddButton extends StatefulWidget {
  final void Function()? onTap;
  const AddButton({super.key, this.onTap});

  @override
  State<AddButton> createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  bool isOpen = false;
  @override
  Widget build(context) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          height: 40,
          width: 40,
          child: Material(
            clipBehavior: Clip.antiAlias,
            color: AppColor.kPrimaryButtonColor,
            borderRadius: BorderRadius.circular(30),
            child: InkWell(
              onTap: widget.onTap,
              onTapDown: (details) => setState(() => isOpen = !isOpen),
              child: Icon(
                isOpen ? Icons.remove : Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
}
