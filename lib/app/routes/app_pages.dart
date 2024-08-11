import 'package:get/get.dart';

import '../modules/banned/bindings/banned_binding.dart';
import '../modules/banned/views/banned_view.dart';

import '../modules/new_update/bindings/new_update_binding.dart';
import '../modules/new_update/views/new_update_view.dart';

import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.NEW_UPDATE,
      page: () => const NewUpdateView(),
      binding: NewUpdateBinding(),
    ),
    GetPage(
      name: _Paths.BANNED,
      page: () => const BannedView(),
      binding: BannedBinding(),
    ),
  ];
}
