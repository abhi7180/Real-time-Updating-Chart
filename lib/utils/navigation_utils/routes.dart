import 'package:get/get.dart';
import 'package:real_time_updating_chart/module/chart_screen/view/price_chart_screen.dart';
import 'package:real_time_updating_chart/splash_screen.dart';

mixin Routes {
  static const defaultTransition = Transition.rightToLeft;

  static const String splash = '/splash';
  static const String priceChartScreen = '/PriceChartScreen';

  static List<GetPage<dynamic>> pages = [
    GetPage<dynamic>(
      name: splash,
      page: () => const SplashScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: priceChartScreen,
      page: () => PriceChartScreen(),
      transition: defaultTransition,
    ),
  ];
}
