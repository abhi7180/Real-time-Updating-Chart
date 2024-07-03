import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:real_time_updating_chart/utils/app_string.dart';
import 'package:real_time_updating_chart/utils/navigation_utils/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppString.chart,
      initialBinding: AppBidding(),
      initialRoute: Routes.splash,
      getPages: Routes.pages,
    );
  }
}

class AppBidding extends Bindings {
  @override
  void dependencies() {}
}
