import 'package:controlcar_app_test/app/app_routes.dart';
import 'package:controlcar_app_test/app/app_theme.dart';
import 'package:controlcar_app_test/controllers/pokemon_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Controlcar App Test',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme(context),
      defaultTransition: Transition.leftToRight,
      initialRoute: AppRoutes.splash,
      getPages: AppRoutes.pages,
      initialBinding: BindingsBuilder(() {
        Get.put(PokemonController());
      }),
    );
  }
}
