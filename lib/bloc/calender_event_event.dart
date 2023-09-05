part of 'calender_event_bloc.dart';

sealed class CalenderEventEvent extends Equatable {
  const CalenderEventEvent();
}

final class AddEventToCalenderEvent extends CalenderEventEvent {
  final EventModel eventModel;

  const AddEventToCalenderEvent({required this.eventModel});

  @override
  List<Object> get props => [eventModel];
}

final class RemoveEventToCalenderEvent extends CalenderEventEvent {
  final List<EventID> eventId;
  final String calendartId;

  const RemoveEventToCalenderEvent({
    required this.eventId,
    required this.calendartId,
  });

  @override
  List<Object> get props => [eventId, calendartId];
}
