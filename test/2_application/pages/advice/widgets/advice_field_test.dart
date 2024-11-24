import 'package:advicer/2_application/pages/advice/widgets/advice_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  Widget widgetUnderTest({required String adviceText}) {
    return MaterialApp(home: AdviceField(advice: adviceText));
  }

  group('AdviceField', () {
    group('Should be displayed correctly', () {
      testWidgets('When a short text is given ', (widgetTester) async {
        const text = 'a';
        await widgetTester.pumpWidget(widgetUnderTest(adviceText: text));
        await widgetTester.pumpAndSettle();
        final adviceFieldFinder = find.textContaining('a');
        expect(adviceFieldFinder, findsOneWidget);
      });

      testWidgets('When a long  text is given ', (widgetTester) async {
        const text = 'hello flutter developers,I hope you enjoy this course, and have a great time. The Sun is shining and I am  ready for a very long weekend';
        await widgetTester.pumpWidget(widgetUnderTest(adviceText: text));
        await widgetTester.pumpAndSettle();
        final adviceFieldFinder = find.byType(AdviceField);
        expect(adviceFieldFinder, findsOneWidget);
      });

      testWidgets('When no text is given', (widgetTester) async {
        const text = '';
        await widgetTester.pumpWidget(widgetUnderTest(adviceText: text));
        await widgetTester.pumpAndSettle();
      //  final adviceFieldFinder = find.text(AdviceField.emptyAdvice);
      //   expect(adviceFieldFinder, findsOneWidget);
        final adviceText = widgetTester.widget<AdviceField>(find.byType(AdviceField)).advice;
        expect(adviceText,'');
      });
    });
  });
}
