import 'package:advicer/2_application/core/services/theme_service.dart';
import 'package:advicer/2_application/pages/advice/advice_page.dart';
import 'package:advicer/2_application/pages/advice/cubit/advicer_cubit.dart';
import 'package:advicer/2_application/pages/advice/widgets/advice_field.dart';
import 'package:advicer/2_application/pages/advice/widgets/error_message.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

//!
//!  abstract class AdvicerCubitState extends Equatable {
//!    const AdvicerCubitState();
//!    @override
//!    List<Object?> get props => [];
//!  }
//!
//!   class AdvicerCubit extends Cubit<AdvicerCubitState>
//!
//!   class MockAdvicerCubit extends MockCubit<AdvicerCubitState>
//!    implements AdvicerCubit {}    <<<<<<<<
//!
//!   MockCubit  -->  provided by  mock_bloc.dart
//!
//!
//!
//!

class MockAdvicerCubit extends MockCubit<AdvicerCubitState>
    implements AdvicerCubit {}

void main() {

  Widget widgetUnderTest({required AdvicerCubit cubit}) {
    return MaterialApp(
        home: ChangeNotifierProvider(
      create: (context) => ThemeService(),
      child: BlocProvider<AdvicerCubit>(
        create: (context) => cubit,
        child: const AdvicerPage(),
      ),
    ));
  }

  group('AdvicerPage', () {
    late MockAdvicerCubit mockAdvicerCubit;
    setUp(() {
      mockAdvicerCubit = MockAdvicerCubit();
    });
    group('Should be displayed in viewState', () {
      testWidgets('Initial when cubits emits AdviceInitial()',
          (widgetTester) async {
        whenListen(
          (mockAdvicerCubit),
          Stream.fromIterable(const [AdvicerInitial()]),
          initialState: const AdvicerInitial(),
        );
        await widgetTester.pumpWidget(widgetUnderTest(cubit: mockAdvicerCubit));
        final initialStateTextFinder =
            find.text('Your advice is waiting for you');
        expect(initialStateTextFinder, findsOneWidget);
      });

      testWidgets('Initial when cubits emits AdviceStateLoading()',
          (widgetTester) async {
        whenListen(
          (mockAdvicerCubit),
          Stream.fromIterable(const [AdvicerStateLoading()]),
          initialState: const AdvicerInitial(),
        );
        await widgetTester.pumpWidget(widgetUnderTest(cubit: mockAdvicerCubit));
        await widgetTester.pump();
        //!
        //!  find  is used to find a widget for the test
        //!
        final adviceLoadingWidgetFinder =
            find.byType(CircularProgressIndicator);
        expect(adviceLoadingWidgetFinder, findsOneWidget);
      });

      testWidgets('AdviceField widget should be displayed when cubits emits AdviceStateLoaded()',
          (widgetTester) async {
        whenListen(
          (mockAdvicerCubit),
          Stream.fromIterable(const [AdvicerStateLoaded(advice: 'advice')]),
          initialState: const AdvicerInitial(),
        );
        await widgetTester.pumpWidget(widgetUnderTest(cubit: mockAdvicerCubit));
        await widgetTester.pump();  /* wait for it */

        final advicerLoadedStateFinder = find.byType(AdviceField);// find the widget
        expect(advicerLoadedStateFinder, findsOneWidget);
        //!
        //!   widgetTester.widget<T>(a widget of type T).anyField   gives a widget instance and gives you access to its fields
        //!
        final advicerText = widgetTester.widget<AdviceField>(advicerLoadedStateFinder).advice;
        expect (advicerText,'advice');



      });

      testWidgets('ErrorMessage widget should be displayed when cubits emits ErrorStateLoaded()',
              (widgetTester) async {
            whenListen(
              (mockAdvicerCubit),
              Stream.fromIterable(const [AdvicerStateError(message:'error')]),
              initialState: const  AdvicerInitial(),
            );

            await widgetTester.pumpWidget(widgetUnderTest(cubit: mockAdvicerCubit));
            await widgetTester.pump();

            final errorMessageWidget = find.byType(ErrorMessage); //  find the  widget
            expect(errorMessageWidget, findsOneWidget);  //  should find it
            final errorMessage = widgetTester.widget<ErrorMessage>(errorMessageWidget).message;
            expect(errorMessage,'error');

          });
    });
  });
}
