import 'package:advicer/2_application/core/services/theme_service.dart';
import 'package:advicer/2_application/pages/advice/widgets/custom_button.dart';
import 'package:advicer/2_application/pages/advice/widgets/error_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
//import 'bloc/advicer_bloc.dart';
import '../../../injection.dart';
import 'cubit/advicer_cubit.dart';
import 'widgets/advice_field.dart';
import 'widgets/advice_id_input.dart';


//  Wrap AdvicerPage with a provider
class AdvicerPageWrapperProvider extends StatelessWidget {
  const AdvicerPageWrapperProvider({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      //
      // !  create: (context) => AdvicerCubit(),
      //  ! take  AdvicerCubit  from the service locator
      //
      create: (context) => sl<AdvicerCubit>(),  // dependency injection sl
      // create: (context) => AdvicerBloc(),
      child: const AdvicerPage(),
    );
  }
}
/*
sl<AdvicerCubit>(),
class AdvicerPageBlocProvider extends StatelessWidget {
  const AdvicerPageBlocProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AdvicerBloc(),
        child: const Placeholder());
  }
}

 */

class AdvicerPage extends StatelessWidget {
  const AdvicerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Advicer',
            style: themeData.textTheme.headlineLarge,
          ),
          centerTitle: true,
          actions: [
            Switch(
                value: Provider.of<ThemeService>(context).isDarkModeOn,
                onChanged: (_) {
                  Provider.of<ThemeService>(context, listen: false)
                      .toggleTheme();
                })
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            children: [
              Expanded(
                  child:
                      Center(child: BlocBuilderWidget(themeData: themeData))),
              //const SizedBox(height: 150, child: Center(child: CustomButton(id:5)))
              const SizedBox(
                  height: 300, child: Center(child: AdviceIdInput()))
            ],
          ),
        ));
  }
}

class BlocBuilderWidget extends StatelessWidget {
  const BlocBuilderWidget({
    super.key,
    required this.themeData,
  });

  final ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdvicerCubit, AdvicerCubitState>(
      //  Center(child: BlocBuilder<AdvicerBloc, AdvicerState>(
      builder: (context, state) {
        switch (state) {
          case final AdvicerInitial state:
            return Text('Your advice is waiting for you',
              style: themeData.textTheme.headlineMedium,
            );
          case final AdvicerStateLoading _:
            return CircularProgressIndicator(
              color: themeData.colorScheme.secondary,
            );
          case final AdvicerStateLoaded state:
            return AdviceField(advice: state.advice);
          case final AdvicerStateError state:
            return ErrorMessage(message: state.message);
          default:
            return const SizedBox();
        }
      },
    );
  }
}
