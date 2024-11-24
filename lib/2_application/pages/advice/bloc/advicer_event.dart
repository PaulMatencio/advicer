part of 'advicer_bloc.dart';

@immutable
abstract class AdvicerEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AdviceRequestedEvent extends AdvicerEvent {
  //! final String input ;
  //! AdviceRequestedEvent({ required this.input});
  //!  final String input;
  //!  AdviceRequestedEvent({required this.input});
  AdviceRequestedEvent();
  @override
  List<Object?> get props => [];
}
