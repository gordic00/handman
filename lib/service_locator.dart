import 'package:get_it/get_it.dart';
import 'package:handman/core/network/dio_client.dart';
import 'package:handman/service/auth_api_service.dart';
import 'package:handman/service/auth_local_service.dart';
import 'package:handman/service/test_service.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  //services
  sl.registerSingleton<DioClient>(DioClient());

  sl.registerSingleton<AuthApiService>(AuthApiServiceImpl());

  sl.registerSingleton<AuthLocalService>(AuthLocalServiceImpl());

  sl.registerSingleton<TestService>(TestServiceImpl());
}
