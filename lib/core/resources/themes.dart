import 'package:flutter/material.dart';
import 'package:one_vpn/core/resources/colors.dart';

ThemeData get lightTheme => ThemeData.light(useMaterial3: false).copyWith(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundLight,
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
      ),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.all(primaryColor),
      ),
      colorScheme: ColorScheme.light(
        primary: primaryColor,
        onPrimary: Colors.white,
        background: backgroundLight,
        secondary: secondaryColor,
        brightness: Brightness.light,
        shadow: shadowColor,
        surface: surfaceLight,
      ),
    );

ThemeData get darkTheme => ThemeData.dark(useMaterial3: false).copyWith(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundDark,
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.all(primaryColor),
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
      ),
      colorScheme: ColorScheme.dark(
        primary: primaryColor,
        onPrimary: Colors.white,
        background: backgroundDark,
        secondary: secondaryColor,
        brightness: Brightness.dark,
        shadow: shadowColor,
        surface: surfaceDark,
      ),
    );

TextTheme textTheme(BuildContext context) => Theme.of(context).textTheme;
