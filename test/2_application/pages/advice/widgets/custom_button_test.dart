import 'package:advicer/2_application/pages/advice/cubit/advicer_cubit.dart';
import 'package:advicer/2_application/pages/advice/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';


abstract class OnCustomButtonTap {
  void call();
}

class MockOnCustomButtonTap extends Mock implements OnCustomButtonTap {}

void main() {
  String label = 'Get Advice';
  final mockOnCustomButtonTap = MockOnCustomButtonTap();

  Widget widgetUnderTest = WidgetUnderTest(onTap: mockOnCustomButtonTap.call,);
 //!Widget widgetUnderTest = WidgetUnderTest(onTap: () {}); // empty function


  group('CustomButton', () {
    group('is Button render correctly', () {
      testWidgets('and has all parts that he needs', (widgetTester) async {
        await widgetTester.pumpWidget(widgetUnderTest);
        final buttonLabelFinder = find.text(label);
        expect(buttonLabelFinder, findsOneWidget);
      });
    });

    group('should handle onTap', () {
      testWidgets('when someone has pressed the button', (widgetTester) async {
        await widgetTester.pumpWidget(widgetUnderTest);
        final customButtonFinder = find.byType(CustomButton);
        await widgetTester.tap(customButtonFinder);
        verify(mockOnCustomButtonTap()).called(1);
      });
    });

  });
}

class WidgetUnderTest extends StatelessWidget {
  final Function() ? onTap;
  const WidgetUnderTest({super.key,this.onTap});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: CustomButton(
          id: null,
          onTap: onTap,
    )));
  }

}
