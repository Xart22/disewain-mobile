import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/dashboard/bindings/dashboard_binding.dart';
import '../modules/home/detail/bindings/detail_binding.dart';
import '../modules/home/detail/views/detail_view.dart';
import '../modules/home/logs/bindings/logs_binding.dart';
import '../modules/home/logs/views/logs_view.dart';
import '../modules/home/rekap_data/bindings/rekap_data_binding.dart';
import '../modules/home/settings/bindings/settings_binding.dart';
import '../modules/home/tracking/bindings/tracking_binding.dart';
import '../modules/home/tracking/views/tracking_view.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/maps/bindings/maps_binding.dart';
import '../modules/maps/views/maps_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      bindings: [
        HomeBinding(),
        DashboardBinding(),
        RekapDataBinding(),
        SettingsBinding(),
      ],
    ),
    GetPage(
      name: _Paths.TRACKING,
      page: () => const TrackingView(),
      binding: TrackingBinding(),
    ),
    GetPage(
      name: _Paths.LOGS,
      page: () => const LogsView(),
      binding: LogsBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.MAPS,
      page: () => const MapsView(),
      binding: MapsBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL,
      page: () => const DetailView(),
      binding: DetailBinding(),
    ),
  ];
}
