import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:controlcar_app_test/utils/constants.dart';

class AppTheme {
  static ThemeData theme(BuildContext context) {
    return ThemeData(
      primarySwatch: Colors.blue,
      textTheme: GoogleFonts.robotoTextTheme(
        Theme.of(context).textTheme,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Constants.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Constants.primaryColor,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: Constants.primaryColor,
              elevation: 0,
              foregroundColor: Colors.white)),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: Constants.primaryColor,
      ),
    );
  }
}
