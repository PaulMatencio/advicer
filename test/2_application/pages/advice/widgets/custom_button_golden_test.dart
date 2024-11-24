
import 'package:advicer/2_application/pages/advice/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

//!
//!   flutter test --update-goldens     to generate golden files
//!   ---- >  check the widgets/goldens folder to see the master image
//!
//!   Run  the golden test
//!      if it fails
//!           -> check the widgets/failures  folder to see why
//!

class WidgetUnderTest extends StatelessWidget {
  final int ? id;
  final Function() ? onTap;
  const WidgetUnderTest({super.key,required this.id, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        home:Scaffold(
            body: CustomButton(id:id,onTap:onTap)));
  }
}

void main() {
    group('Golden test', () {
      group('CustomButton', () {
        testWidgets('is enabled', (widgetTester) async {
          await widgetTester.pumpWidget(WidgetUnderTest(id: null, onTap: () {}));
          await expectLater(find.byType(CustomButton), matchesGoldenFile('goldens/custom_button_enabled.png'));
        });

        testWidgets('is disabled', (widgetTester) async {
          await widgetTester.pumpWidget(const WidgetUnderTest(id: null, onTap: null));
          await expectLater(find.byType(CustomButton), matchesGoldenFile('goldens/custom_button_disabled.png'));
        });

      });
    });
}

