import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'advicer_event.dart';
part 'advicer_state.dart';

//!
//!   https://bloclibrary.dev/getting-started/
//!
//!


class AdvicerBloc extends Bloc<AdvicerEvent, AdvicerState> {
  AdvicerBloc() : super(AdvicerInitial()) {

    on<AdviceRequestedEvent>((event, emit) async {
     // debugPrint ( event.input);
      emit(AdvicerStateLoading());

      // execute business logic
      // for example get and advice

      debugPrint('fake get advice triggered');
      await Future.delayed(const Duration(seconds: 3), () {});
      debugPrint('got advice');
      //!
      //!  either emit advice or error,
      //!  comment out when you want to test
      //!
      emit(AdvicerStateLoaded(advice: 'fake advice to test bloc'));
      //!
      //!   emit(AdvicerStateError(message: 'error message'));
      //!
    }
    );
  }
}