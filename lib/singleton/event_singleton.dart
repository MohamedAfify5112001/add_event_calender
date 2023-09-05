import 'package:add_event_to_calendar/model/event_id.dart';

class EventsInstance {
  static final EventsInstance _singleton = EventsInstance._internal();
  List<EventID> events = [];

  factory EventsInstance() {
    return _singleton;
  }

  EventsInstance._internal();
}
