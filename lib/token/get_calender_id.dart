import 'package:device_calendar/device_calendar.dart';

Future<(bool, String?)> retrieveCalendarId() async {
  // Create an instance of the calendar provider
  final calendarProvider = DeviceCalendarPlugin();

  // Check if the user has granted permission
  final permissionStatus = await calendarProvider.hasPermissions();
  if (permissionStatus.isSuccess && !permissionStatus.data!) {
    // Request permission to access calendars
    var arePermissionsGranted = await calendarProvider.requestPermissions();
    // Handle the case where permission is not granted
    if (!arePermissionsGranted.isSuccess || !arePermissionsGranted.data!) {
      return (false, null);
    }
  }
  // Retrieve the list of calendars on the device
  final calendarsResult = await calendarProvider.retrieveCalendars();
  if (calendarsResult.isSuccess && calendarsResult.data!.isNotEmpty) {
    // Assuming you want to retrieve the first calendar
    final calendar = calendarsResult.data!.first;
    final calendarId = calendar.id;
    print('Calendar ID: $calendarId');
    return (true, calendarId);
  }
  return (false, null);
}
