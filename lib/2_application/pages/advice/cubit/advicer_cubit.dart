import 'package:advicer/1_domain/usecases/advice_usecases.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../1_domain/failures/failures.dart';

part 'advicer_state.dart';

const generalFailureMessage = 'Ups,something gone wrong. Please try again';
const serverFailureMessage = 'Ups, Api error';
const cacheFailureMessage = 'Ups, cache failed . Please try again';
const dataExceptionMessage =' Ups,bad json data';

//!
//!   https://bloclibrary.dev/getting-started/
//!
//!


class AdvicerCubit extends Cubit<AdvicerCubitState> {
  final AdviceUseCases adviceUseCases;
  AdvicerCubit({required this.adviceUseCases}) : super(const AdvicerInitial());

 // final AdviceUseCases adviceUseCases = AdviceUseCases();
  // AdvicerCubit({required this.adviceUseCases});
  //  could also  have other use cases

  void adviceRequested(int ? id) async {
    emit(const AdvicerStateLoading());
    final failureOrAdvice = await adviceUseCases.getAdvice(id);
    // final failureOrAdvice = await adviceUseCases.getAdviceFromCloud();
    failureOrAdvice.fold(
        (failure) =>
            emit(AdvicerStateError(message: _mapFailureToMessage(failure))),
        //!  store the result
        (advice) => emit(AdvicerStateLoaded(advice: advice.advice)));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure) {
      case final ServerFailure e:
        String ? message = (e.message ==  null) ? serverFailureMessage: e.message;
        return ('$serverFailureMessage => $message');
      case final CacheFailure _:
        return cacheFailureMessage;
      case final DataFailure e :
        return e.message;
      default:
        return generalFailureMessage;
    }
  }

  /* called by custom_button.dart */
  /*
  void adviceRequested() async {
    emit(AdvicerStateLoading());
    debugPrint('fake get advice triggered');
    await Future.delayed(const Duration(seconds: 3), () {});
    debugPrint('got advice');
    emit(const AdvicerStateLoaded(advice: 'Got fake advice to test bloc'));
    await Future.delayed(const Duration(seconds: 2), () {});
    emit(const AdvicerStateError(message: 'Oups! something went wrong '));
  }

   */
}
