import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppie_mart/app/core/theme/my_colors.dart';

ThemeData lightThemeData(BuildContext context) {
  return ThemeData.light().copyWith(
    primaryColor: MyColors.appColor1,
    scaffoldBackgroundColor: MyColors.white,
    appBarTheme: const AppBarTheme(
        centerTitle: false, elevation: 0, color: MyColors.appColor1),
    iconTheme: const IconThemeData(color: MyColors.black),
    textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
        .apply(bodyColor: MyColors.textColor),
    radioTheme: RadioThemeData(
        fillColor: WidgetStateColor.resolveWith(
            (states) => MyColors.lightContainerColor),
        overlayColor: WidgetStateColor.resolveWith(
            (states) => MyColors.themeOrangeColor)),
    colorScheme: const ColorScheme.light(
        primary: MyColors.textColor,
        onPrimary: MyColors.themeOrangeColor,
        secondary: MyColors.textLightColor,
        primaryContainer: MyColors.lightContainerColor,
        secondaryContainer: MyColors.black,
        error: MyColors.red),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      elevation: 1,
      backgroundColor: MyColors.lightContainerColor,
      selectedItemColor: MyColors.textColor,
      unselectedItemColor: MyColors.textLightColor,
      selectedIconTheme: IconThemeData(color: MyColors.textLightColor),
      showUnselectedLabels: true,
    ),
  );
}
