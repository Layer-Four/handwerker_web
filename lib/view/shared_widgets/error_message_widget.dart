import 'package:flutter/material.dart';

class ErrorMessageWidget extends StatelessWidget {
  final String message;
  const ErrorMessageWidget(this.message, {super.key});
  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: AlertDialog(
          backgroundColor: Colors.white,
          content: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 24),
            child: Text(message),
          ),
        ),
      );
}
