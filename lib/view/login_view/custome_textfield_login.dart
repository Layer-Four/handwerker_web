import 'package:flutter/material.dart';
import '../../constants/themes/app_color.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final bool isPassword;
  final TextInputAction inputAction;
  final bool obscureText;
  final Function(String)? onFieldSubmitted;
  final Function()? togglePasswordVisibility;
  final String? Function(String?)? validator;
  final Function(bool)? onFocusChange;
  final Iterable<String>? autofillHints;

  const CustomTextField({
    super.key,
    required this.controller,
    this.isPassword = false,
    required this.inputAction,
    this.obscureText = false,
    this.onFieldSubmitted,
    this.togglePasswordVisibility,
    this.validator,
    this.onFocusChange,
    this.autofillHints,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isPasswordVisible = false;
  @override
  Widget build(
    BuildContext context,
  ) =>
      Container(
        margin: const EdgeInsets.only(top: 3, bottom: 20),
        width: 355,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color.fromARGB(255, 231, 226, 226),
        ),
        child: Focus(
          onFocusChange: widget.onFocusChange,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: 44,
            width: 355,
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              autofocus: true,
              keyboardType: widget.isPassword ? TextInputType.text : TextInputType.emailAddress,
              textInputAction: widget.inputAction,
              validator: widget.validator,
              onFieldSubmitted: widget.onFieldSubmitted,
              controller: widget.controller,
              obscureText: widget.isPassword && !isPasswordVisible,
              autofillHints: widget.autofillHints,
              decoration: InputDecoration(
                errorStyle: const TextStyle(fontSize: 0.01),
                filled: true,
                fillColor: Colors.transparent,
                contentPadding: const EdgeInsets.all(10),
                suffixIcon: widget.isPassword
                    ? IconButton(
                        onPressed: () => isPasswordVisible = !isPasswordVisible,
                        icon: Icon(isPasswordVisible ? Icons.visibility_off : Icons.visibility),
                        color: Theme.of(context).iconTheme.color,
                      )
                    : null,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: AppColor.kPrimaryButtonColor,
                    width: 2,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: AppColor.kPrimaryButtonColor,
                    width: 2,
                    style: BorderStyle.solid,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Colors.red,
                    width: 2,
                    style: BorderStyle.solid,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Colors.red,
                    width: 2,
                    style: BorderStyle.solid,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
