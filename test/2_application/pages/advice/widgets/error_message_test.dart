import 'package:advicer/2_application/pages/advice/widgets/error_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void  main() {
    group('ErrorMessage', () {
      group('Should display correctly', () {
        testWidgets('When an error message is given ', (widgetTester) async {
          const text = 'Ups! there is an error';
          await widgetTester.pumpWidget(const WidgetUnderTest(message: text));
          // final errorMessageFinder = find.byType(ErrorMessage);
          final errorMessageFinder = find.text(text);
          expect(errorMessageFinder, findsOneWidget);
        });
      });

      testWidgets('When no error message is given', (widgetTester) async {
        const text = '';
        await widgetTester.pumpWidget(const WidgetUnderTest(message: text));
        final errorMessageFieldFinder = find.text(ErrorMessage.emptyErrorMessage);
        expect(errorMessageFieldFinder, findsOneWidget);
        final errorMessageText = widgetTester.widget<ErrorMessage>(find.byType(ErrorMessage)).message;
        expect(errorMessageText,'');
      });
    });
}

class WidgetUnderTest extends StatelessWidget {
  const WidgetUnderTest({super.key,required this.message});
  final String message ;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: ErrorMessage(message: message)
    );
  }
}
