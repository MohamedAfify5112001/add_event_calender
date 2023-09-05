import 'package:add_event_to_calendar/bloc/calender_event_bloc.dart';
import 'package:add_event_to_calendar/locator/locator.dart';
import 'package:add_event_to_calendar/model/event_id.dart';
import 'package:timezone/timezone.dart' as tz;

import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/event_model.dart';
import '../singleton/event_singleton.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String calenderId = "";

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CalenderEventBloc, CalenderEventState>(
      listener: (context, state) {
        if (state is SuccessAddEventToCalenderState) {
          calenderId = state.calenderId;
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    BlocProvider.of<CalenderEventBloc>(context).add(
                      AddEventToCalenderEvent(
                        eventModel: EventModel(
                          title: 'Study Design Pattern',
                          desc:
                              "Study All Principles of Design Pattern (Creation , Structure , Behavior)",
                          startDate: TZDateTime.from(
                            DateTime.now(),
                            tz.getLocation(instance<String>()),
                          ),
                          endDate: TZDateTime.from(
                            DateTime.now().add(const Duration(days: 1)),
                            tz.getLocation(instance<String>()),
                          ),
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    "Add Event",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<CalenderEventBloc>(context).add(
                      RemoveEventToCalenderEvent(
                        eventId: EventsInstance().events,
                        calendartId: calenderId,
                      ),
                    );
                  },
                  child: const Text(
                    "Delete Event",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
