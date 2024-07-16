import 'package:flutter/material.dart';

class WaitingMessageWidget extends StatelessWidget {
  final String message;
  const WaitingMessageWidget(this.message, {super.key});
  @override
  Widget build(BuildContext context) => Column(mainAxisSize: MainAxisSize.min, children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(60.0),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
        ),
        const CircularProgressIndicator(),
      ]);
}
