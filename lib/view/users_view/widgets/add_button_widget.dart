import 'package:flutter/material.dart';

import '../../../constants/themes/app_color.dart';

class AddButton extends StatelessWidget {
  final void Function()? onTap;
  final bool isOpen;

  final Widget hideAbleChild;
  const AddButton({
    super.key,
    this.onTap,
    required this.hideAbleChild,
    required this.isOpen,
  });

  @override
  Widget build(context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              height: 40,
              width: 40,
              child: Material(
                clipBehavior: Clip.antiAlias,
                color: AppColor.kPrimaryButtonColor,
                borderRadius: BorderRadius.circular(30),
                child: InkWell(
                  onTap: onTap,
                  child: Icon(
                    isOpen ? Icons.remove : Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          isOpen ? hideAbleChild : const SizedBox.shrink(),
        ],
      );
}
