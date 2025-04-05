import 'package:advanced_course_udemy/app/app_prefs.dart';
import 'package:advanced_course_udemy/data/data_source/remote_data_source.dart';
import 'package:advanced_course_udemy/data/network/app_api.dart';
import 'package:advanced_course_udemy/data/network/dio_factory.dart';
import 'package:advanced_course_udemy/data/network/network_info.dart';
import 'package:advanced_course_udemy/data/repository/repository_impl.dart';
import 'package:advanced_course_udemy/domain/repository/repository.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  // SharedPreferences
  instance.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  // AppPreferences
  instance.registerLazySingleton<AppPrefs>(() => AppPrefs(instance()));

  // NetworkInfo
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker.createInstance()));

  // Dio factory
  instance.registerLazySingleton(() => DioFactory(instance()));

  // App service client
  final dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton(() => AppServiceClient(dio));

  // Remote data source
  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(instance()));

  // Repository
  instance.registerLazySingleton<Repository>(
      () => RepositoryImpl(instance(), instance()));

  
}
