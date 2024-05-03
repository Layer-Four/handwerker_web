import 'package:flutter/material.dart';

import '../../../constants/themes/app_color.dart';

class UserAndPasswordField extends StatefulWidget {
  final TextEditingController? controller;
  final bool isPass;
  final String? hintText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;

  const UserAndPasswordField({
    super.key,
    this.controller,
    this.isPass = false,
    this.validator,
    this.hintText,
    this.keyboardType,
    this.obscureText = true,
  });

  @override
  State<UserAndPasswordField> createState() => _UserAndPasswordFieldState();
}

class _UserAndPasswordFieldState extends State<UserAndPasswordField> {
  bool obscure = true;
  bool isFocused = false;
  GlobalKey<FormState> formstate = GlobalKey();

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColor.kWhiteWOpacity,
        ),
        child: Focus(
          onFocusChange: (hasFocus) {
            setState(() {
              isFocused = hasFocus;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: isFocused ? 48 : 44,
            child: TextFormField(
              textInputAction: TextInputAction.next,

              validator: (value) => (value == null || value.isEmpty)
                  ? 'Required'
                  : (value.length < 3
                      ? 'Password must be at least 6 characters'
                      : null),

              // validator: (value) => value!.length < 6 ? "Required" : null,
              obscureText: widget.isPass ? obscure : false,
              controller: widget.controller,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                hintText: widget.hintText,
                hintStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.transparent,
                suffixIcon: widget.isPass
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            obscure = !obscure;
                          });
                        },
                        icon: const Icon(Icons.remove_red_eye))
                    : const SizedBox(),
                // contentPadding: const EdgeInsets.all(8),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 16, horizontal: 8), // Adjust vertical padding

                isDense: true,

                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: AppColor.kPrimaryButtonColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: isFocused
                        ? AppColor.kPrimaryButtonColor
                        : Colors.transparent,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
