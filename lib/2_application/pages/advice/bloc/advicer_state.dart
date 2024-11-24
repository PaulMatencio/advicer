part of 'advicer_bloc.dart';

@immutable
abstract class AdvicerState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AdvicerInitial extends AdvicerState {
  getInitial() => 'Your advice is waiting for you !';
}

class AdvicerStateLoading extends AdvicerState {}


class AdvicerStateLoaded extends AdvicerState {
  final String advice;
  AdvicerStateLoaded({required this.advice});
  getAdvice() => advice;
  //  equatable
  @override
  List<Object?> get props => [advice];
}

class AdvicerStateError extends AdvicerState {
  final String message;
  AdvicerStateError({required this.message});
  getMessage() => message;
  @override
  List<Object?> get props => [message];
}