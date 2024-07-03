import 'package:flutter/material.dart';
import 'package:real_time_updating_chart/utils/app_colors.dart';
import 'package:real_time_updating_chart/utils/app_string.dart';
import 'package:real_time_updating_chart/utils/navigation_utils/routes.dart';

import 'utils/navigation_utils/navigation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      navigateFurther(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SizedBox(
        key: ValueKey("Container"),
        width: double.maxFinite,
        child: Center(
          child: Text(
            AppString.chart,
            style: TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> navigateFurther(BuildContext context) async {
    Navigation.replace(Routes.priceChartScreen);
  }
}
