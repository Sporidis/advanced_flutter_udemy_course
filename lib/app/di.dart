import 'package:advanced_course_udemy/app/app_prefs.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  // SharedPreferences
  instance.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  // AppPreferences
  instance.registerLazySingleton<AppPrefs>(() => AppPrefs(instance()));
}
