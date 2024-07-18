import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/themes/app_color.dart';

final passwordVisibilityProvider = StateProvider((ref) => false);

class CustomTextField extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isPasswordVisible = ref.watch(passwordVisibilityProvider);
    void togglePasswordVisibility() {
      ref.read(passwordVisibilityProvider.notifier).state = !ref.watch(passwordVisibilityProvider);
    }

    return Container(
      margin: const EdgeInsets.only(top: 3, bottom: 20),
      width: 355,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color.fromARGB(255, 231, 226, 226),
      ),
      child: Focus(
        onFocusChange: onFocusChange,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: 44,
          width: 355,
          child: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            autofocus: true,
            keyboardType: isPassword ? TextInputType.text : TextInputType.emailAddress,
            textInputAction: inputAction,
            validator: validator,
            onFieldSubmitted: onFieldSubmitted,
            controller: controller,
            obscureText: isPassword && !isPasswordVisible,
            autofillHints: autofillHints,
            decoration: InputDecoration(
              errorStyle: const TextStyle(fontSize: 0.01),
              filled: true,
              fillColor: Colors.transparent,
              contentPadding: const EdgeInsets.all(10),
              suffixIcon: isPassword
                  ? IconButton(
                      onPressed: togglePasswordVisibility,
                      icon: Icon(isPasswordVisible ? Icons.visibility_off : Icons.visibility),
                      color: Theme.of(context).iconTheme.color,
                    )
                  : null,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: AppColor.kPrimaryButtonColor,
                  width: 2,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
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
}
