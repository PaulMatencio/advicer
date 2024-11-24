
import 'package:advicer/2_application/pages/advice/widgets/advice_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';


class WidgetUnderTest extends StatelessWidget {
  final String advice;
  const WidgetUnderTest({super.key,required this.advice});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AdviceField(advice: advice)
    );
  }
}


void main() {
  
  group('GoldenTest', () {
    group('AdviceField',() {
      testWidgets('when advice is displayed', (widgetTester) async {
        await widgetTester.pumpWidget(const WidgetUnderTest(advice: 'Here is some advice',));
          await expectLater(find.byType(AdviceField), matchesGoldenFile('goldens/advice_field_displayed.png'));
      });
      testWidgets('when advice filed is empty', (widgetTester) async {
        await widgetTester.pumpWidget(const WidgetUnderTest(advice: '',));
        await expectLater(find.byType(AdviceField), matchesGoldenFile('goldens/advice_field_is_empty.png'));
      });
    });
  });
  
}



