import 'dart:async';
import 'dart:developer';

import 'package:add_event_to_calendar/model/event_model.dart';
import 'package:add_event_to_calendar/token/get_calender_id.dart';
import 'package:bloc/bloc.dart';
import 'package:device_calendar/device_calendar.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

import '../locator/locator.dart';
import '../model/event_id.dart';
import '../singleton/event_singleton.dart';

part 'calender_event_event.dart';

part 'calender_event_state.dart';

class CalenderEventBloc extends Bloc<CalenderEventEvent, CalenderEventState> {
  CalenderEventBloc() : super(CalenderEventInitial()) {
    on<AddEventToCalenderEvent>(_onAddEventToCalenderEvent);
    on<RemoveEventToCalenderEvent>(_onRemoveEventToCalenderEvent);
  }

  Future<void> _onAddEventToCalenderEvent(
      AddEventToCalenderEvent addEventToCalenderEvent,
      Emitter<CalenderEventState> emit) async {
    final (bool, String?) calenderId = await retrieveCalendarId();
    if (calenderId.$1) {
      final Event eventToCreate = Event(calenderId.$2,
          title: addEventToCalenderEvent.eventModel.title,
          description: addEventToCalenderEvent.eventModel.desc,
          start: addEventToCalenderEvent.eventModel.startDate,
          end: addEventToCalenderEvent.eventModel.endDate,
          allDay: false,
          recurrenceRule: RecurrenceRule(
            RecurrenceFrequency.Monthly,
          ));
      final deviceCalendarPlugin = DeviceCalendarPlugin();

      final createEventResult =
          await deviceCalendarPlugin.createOrUpdateEvent(eventToCreate);
      log('Data ${createEventResult?.data}');

      // instance.registerLazySingleton<List<EventID>>(
      //   () => List.from([])..add(EventID(createEventResult!.data!)),
      // );
      EventsInstance().events.add(EventID(createEventResult!.data!));

      if (createEventResult.isSuccess &&
          (createEventResult.data?.isNotEmpty ?? false)) {
        emit(SuccessAddEventToCalenderState(calenderId.$2 ?? ""));
      } else {
        var errorMessage =
            'Could not create : ${createEventResult.errors.toString()}';
        emit(
          FailedAddEventToCalenderState(
            errorMessage: errorMessage,
          ),
        );
      }
    } else {
      emit(
        const FailedAddEventToCalenderState(
          errorMessage: 'Error In Get Calender',
        ),
      );
    }
  }

  Future<void> _onRemoveEventToCalenderEvent(
      RemoveEventToCalenderEvent removeEventToCalenderEvent,
      Emitter<CalenderEventState> emit) async {
    final deviceCalendarPlugin = DeviceCalendarPlugin();
    if (removeEventToCalenderEvent.eventId.length == 1) {
      await deviceCalendarPlugin.deleteEvent(
        removeEventToCalenderEvent.calendartId,
        removeEventToCalenderEvent.eventId.first.id,
      );
    } else {
      for (var event in removeEventToCalenderEvent.eventId) {
        deviceCalendarPlugin.deleteEvent(
          removeEventToCalenderEvent.calendartId,
          event.id,
        );
      }
    }
    emit(SuccessRemoveEventToCalenderState());
    // try {
    //
    // } catch (_) {
    //   emit(FailedRemoveEventToCalenderState());
    // }
  }
}
