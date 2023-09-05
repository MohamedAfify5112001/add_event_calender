part of 'calender_event_bloc.dart';

sealed class CalenderEventState extends Equatable {
  const CalenderEventState();
}

final class CalenderEventInitial extends CalenderEventState {
  @override
  List<Object> get props => [];
}

final class SuccessAddEventToCalenderState extends CalenderEventState {
  final String calenderId;

  const SuccessAddEventToCalenderState(this.calenderId);

  @override
  List<Object> get props => [];
}

final class FailedAddEventToCalenderState extends CalenderEventState {
  final String errorMessage;

  const FailedAddEventToCalenderState({required this.errorMessage});

  @override
  List<Object> get props => [];
}

final class SuccessRemoveEventToCalenderState extends CalenderEventState {
  @override
  List<Object> get props => [];
}

final class FailedRemoveEventToCalenderState extends CalenderEventState {
  @override
  List<Object> get props => [];
}
