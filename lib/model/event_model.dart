import 'package:device_calendar/device_calendar.dart';
import 'package:equatable/equatable.dart';

final class EventModel extends Equatable {
  final String title;
  final String desc;
  final TZDateTime startDate;
  final TZDateTime endDate;

  const EventModel(
      {required this.title,
      required this.desc,
      required this.startDate,
      required this.endDate});

  @override
  List<Object> get props => [title, desc, startDate, endDate];
}
