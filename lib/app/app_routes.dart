import 'package:controlcar_app_test/screens/captured_screen.dart';
import 'package:controlcar_app_test/screens/home_screen.dart';
import 'package:controlcar_app_test/screens/search_screen.dart';
import 'package:controlcar_app_test/screens/splash_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String home = '/';
  static const String search = '/search';
  static const String captured = '/captured';

  static final pages = [
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: home, page: () => const HomeScreen()),
    GetPage(name: search, page: () => const SearchScreen()),
    GetPage(name: captured, page: () => const CapturedScreen())
  ];
}
