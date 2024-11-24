import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  final String message;
  const ErrorMessage({super.key, required this.message});
  static String emptyErrorMessage = 'no error message!';
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.error,
          size: 40,
          color: Colors.redAccent,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          message.isEmpty ? emptyErrorMessage: message,
          // style: themeData.textTheme.headline1,
          // style: Theme.of(context).textTheme.headLine1
          style: themeData.textTheme.headlineSmall,
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}