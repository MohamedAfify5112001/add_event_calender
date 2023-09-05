import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get_it/get_it.dart';

final instance = GetIt.I;

Future<void> initLocator() async {
  final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
  instance.registerLazySingleton<String>(() => currentTimeZone);
}

