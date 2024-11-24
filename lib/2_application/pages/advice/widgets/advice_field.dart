
import 'package:flutter/material.dart';

class AdviceField extends StatelessWidget {
  final String advice;
  const AdviceField({super.key, required this.advice});
  static  String emptyAdvice = 'Ups! something wrong, no advice';
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Material(
      elevation: 20,
      borderRadius: BorderRadius.circular(15),
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: advice.isNotEmpty? themeData.colorScheme.onPrimary: themeData.colorScheme.error),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Text(
              '''"${ advice.isEmpty ?  emptyAdvice : advice }"''',
              // '''" $advice "''',
              style: themeData.textTheme.bodyLarge,
              //style: themeData.textTheme.bodyText1,
              textAlign: TextAlign.center,
            ),
          )),
    );
  }

}
