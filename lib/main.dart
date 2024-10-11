import 'dart:developer' as dev;

import 'package:controlcar_app_test/app/app_routes.dart';
import 'package:controlcar_app_test/app/app_theme.dart';
import 'package:controlcar_app_test/controllers/pokemon_controller.dart';
import 'package:controlcar_app_test/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

void main() {
  dev.log('[APP] Connected to ${Constants.API_URL}');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: GetMaterialApp(
        title: 'Controlcar App Test',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme(context),
        defaultTransition: Transition.leftToRight,
        initialRoute: AppRoutes.splash,
        getPages: AppRoutes.pages,
        initialBinding: BindingsBuilder(() {
          Get.put(PokemonController());
        }),
      ),
    );
  }
}
