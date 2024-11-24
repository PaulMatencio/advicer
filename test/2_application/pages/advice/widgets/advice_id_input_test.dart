
import 'package:advicer/2_application/pages/advice/cubit/advicer_cubit.dart';
import 'package:advicer/2_application/pages/advice/widgets/advice_field.dart';
import 'package:advicer/2_application/pages/advice/widgets/advice_id_input.dart';
import 'package:advicer/2_application/pages/advice/widgets/custom_button.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';



class WidgetUnderTest extends StatefulWidget {
  const WidgetUnderTest({super.key});

  @override
  State<WidgetUnderTest> createState() => _WidgetUnderTestState();
}

class _WidgetUnderTestState extends State<WidgetUnderTest> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body:  AdviceIdInput()
    ));
  }
}

class MockAdvicerCubit extends MockCubit<AdvicerCubitState>
    implements AdvicerCubit {}



void main() {
  const  widgetUnderTest = WidgetUnderTest();
  late MockAdvicerCubit mockAdvicerCubit;
  setUp(() {
    mockAdvicerCubit = MockAdvicerCubit();
  });
  group('AdviceIdInput',() {
    group('should displayed the input text',() {
      testWidgets('description', (widgetTester) async {
        await  widgetTester.pumpWidget(widgetUnderTest);
        await widgetTester.pumpAndSettle();
        //! Find the AdviceInput widget
        final adviceIdInputFinder = find.byType(AdviceIdInput);
        await widgetTester.enterText(adviceIdInputFinder, "5");
        //! change the state
        whenListen(
          (mockAdvicerCubit),
          Stream.fromIterable(const [AdvicerStateLoaded]),
          initialState: const AdvicerInitial(),
        );
        //! rebuild the widget after the widget has  changed
         await  widgetTester.pump();
        //! expect to find  the  text on the screen
        expect(find.text("5"),findsOneWidget);
      });
    });
  });

}