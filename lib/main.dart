import 'package:flutter_tcc_base_source/core/di/injection_container.dart';
import 'package:flutter_tcc_base_source/core/helpers/app_config.dart';
import 'package:flutter_tcc_base_source/core/helpers/app_utils.dart';
import 'package:flutter_tcc_base_source/core/helpers/global_configs.dart';
import 'package:flutter_tcc_base_source/core/helpers/secure_storage.dart';
import 'package:flutter_tcc_base_source/my_app.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  await AppUtils.init();
  String firstTime = (await sl<SecureStorage>().getCustomString(SecureStorage.isFirstTime));
  runApp(
    AppConfig(
      configUrl: GlobalConfig.configUrlRelease,
      buildFlavor: GlobalConfig.prod,
      child: MyApp(
        isFirstTime: firstTime.isEmpty,
      ),
    ),
  );
}
