import 'package:flutter_tcc_base_source/core/base/presentation/cubit/device_info_cubit.dart';
import 'package:flutter_tcc_base_source/core/di/injection_container.dart';
import 'package:flutter_tcc_base_source/core/helpers/app_constants.dart';
import 'package:flutter_tcc_base_source/features/authentication/presentation/cubit/login_cubit.dart';
import 'package:flutter_tcc_base_source/features/authentication/presentation/view/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_focus_watcher/flutter_focus_watcher.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_tcc_base_source/features/onboarding/presentation/view/introduction_view_screen.dart';

import 'core/helpers/global_configs.dart';
import 'core/locale/locale_delegate.dart';
import 'core/navigation/navigation_center.dart';

class MyApp extends StatefulWidget {
  final bool isFirstTime;

  const MyApp({
    Key? key,
    this.isFirstTime = false,
  }) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<LoginCubit>(),
        ),
        BlocProvider(
          create: (_) => sl<DeviceInfoCubit>(),
        ),
      ],
      child: MaterialApp(
        navigatorKey: NavigationCenter.navigatorKey,
        title: '',
        debugShowCheckedModeBanner: false,
        locale: const Locale(GlobalConfig.languageEn),
        showPerformanceOverlay: false,
        showSemanticsDebugger: false,
        localizationsDelegates: const [
          LocDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale(GlobalConfig.languageEn, ''),
          Locale(GlobalConfig.languageKo, ''),
        ],
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: AppConstants.defaultFont,
        ),
        onGenerateRoute: NavigationCenter.generateRoute,
        home: FocusWatcher(
          child: widget.isFirstTime ? const IntroductionViewScreen() : const LoginScreen(),
        ),
      ),
    );
  }
}
