import 'package:appcentflutterassignment/core/init/theme/i_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemeLight implements IAppTheme {
  static final AppThemeLight _instance = AppThemeLight._init();
  static AppThemeLight get instance => _instance;

  AppThemeLight._init();

  @override
  ThemeData? themeData = ThemeData.light().copyWith(
    textTheme: GoogleFonts.plusJakartaSansTextTheme(),
  );
}
