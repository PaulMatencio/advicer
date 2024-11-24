

import 'package:advicer/2_application/pages/advice/widgets/advice_field.dart';
import 'package:advicer/2_application/pages/advice/widgets/advice_id_input.dart';
import 'package:advicer/2_application/pages/advice/widgets/custom_button.dart';
import 'package:advicer/2_application/pages/advice/widgets/error_message.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:advicer/main.dart' as app;

void main() {

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('test end to end', () {
    testWidgets('tap on CustomButton,verify advice will be loaded',
        (widgetTester) async {
         app.main();
         await widgetTester.pumpAndSettle();
         //!  look for the AdvicerInitial  text
         expect(find.text('Your advice is waiting for you'),findsOneWidget);
        //  expect(find.byType(CustomButton),findsOneWidget);
         // expect(find.byType(AdviceIdInput),findsOneWidget);
         //!  find  the CustomButton
         final customButtonFinder = find.byType(CustomButton);
         final inputFieldFinder = find.byType(AdviceIdInput);
         //!   Get random Advice
         await widgetTester.tap(customButtonFinder);
         await widgetTester.pumpAndSettle();
         expect(find.byType(AdviceField),findsOneWidget);
         //!  get a given Advice Id
         await widgetTester.enterText(inputFieldFinder, "5");
         await widgetTester.tap(customButtonFinder);
         await widgetTester.pumpAndSettle();
         expect(find.byType(AdviceField),findsOneWidget);

         //!  get a out of range advice id
         await widgetTester.enterText(inputFieldFinder, "100");
         await widgetTester.tap(customButtonFinder);
         await widgetTester.pumpAndSettle();
         expect(find.byType(ErrorMessage),findsOneWidget);
         //expect(find.textContaining('Ups, Api error'),findsOneWidget);


    });

  });

}