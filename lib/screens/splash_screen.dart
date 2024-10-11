import 'package:controlcar_app_test/app/app_routes.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:controlcar_app_test/utils/constants.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart'; // Make sure to import your home screen

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Get.offAllNamed(AppRoutes.home);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Constants.primaryColor,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Constants.primaryColor,
        body: Center(
          child: Text('Splash Screen'),
        ),
      ),
    );
  }
}
