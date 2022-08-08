import 'package:flutter_tcc_base_source/core/api/service/base/base_rest_service.dart';
import 'package:flutter_tcc_base_source/core/api/service/payment/payment_rest_service.dart';
import 'package:flutter_tcc_base_source/core/base/presentation/cubit/device_info_cubit.dart';
import 'package:flutter_tcc_base_source/core/di/module/network_module.dart';
import 'package:flutter_tcc_base_source/core/helpers/secure_storage.dart';
import 'package:flutter_tcc_base_source/features/authentication/data/authentication_data_source.dart';
import 'package:flutter_tcc_base_source/features/authentication/domain/repository/authentication_repository.dart';
import 'package:flutter_tcc_base_source/features/authentication/domain/usecase/apple_login_case.dart';
import 'package:flutter_tcc_base_source/features/authentication/domain/usecase/facebook_login_case.dart';
import 'package:flutter_tcc_base_source/features/authentication/domain/usecase/google_login_case.dart';
import 'package:flutter_tcc_base_source/features/authentication/domain/usecase/login_case.dart';
import 'package:flutter_tcc_base_source/features/authentication/presentation/cubit/login_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Data source
  sl.registerLazySingleton<AuthenticationDataSource>(
    () => AuthenticationDataSourceImpl(
      baseRestService: sl(),
    ),
  );

  // Repository
  sl.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(
      authenticationDataSource: sl(),
    ),
  );

  // Use case
  sl.registerLazySingleton<LoginCase>(
    () => LoginCase(
      authenticationRepository: sl(),
    ),
  );

  sl.registerLazySingleton<GoogleLoginCase>(
    () => GoogleLoginCase(
      authenticationRepository: sl(),
    ),
  );

  sl.registerLazySingleton<FacebookLoginCase>(
    () => FacebookLoginCase(
      authenticationRepository: sl(),
    ),
  );

  sl.registerLazySingleton<AppleLoginCase>(
    () => AppleLoginCase(
      authenticationRepository: sl(),
    ),
  );

  // Cubit
  sl.registerLazySingleton<LoginCubit>(
    () => LoginCubit(
      loginCase: sl(),
      googleLoginCase: sl(),
      facebookLoginCase: sl(),
      appleLoginCase: sl(),
    ),
  );
  sl.registerLazySingleton<DeviceInfoCubit>(
    () => DeviceInfoCubit(),
  );

  // Services
  sl.registerLazySingleton<BaseRestService>(() => BaseRestService(sl()));
  sl.registerLazySingleton<PaymentRestService>(() => PaymentRestService());

  // Other
  sl.registerLazySingleton<SecureStorage>(() => SecureStorage());
  sl.registerLazySingleton<Dio>(() => NetworkModule.provideDio());
}
