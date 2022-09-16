import 'package:flutter/material.dart';
import 'package:playflutter/core/theme/theme_dimens.dart';

/// @author jv.lee
/// @date 2022/4/27
/// @description 项目主题颜色
class ThemeColors {
  static final AppColors lightColorPalette = AppColors(
      primary: const Color(0xFF9B9B9B),
      primaryDark: const Color(0xFF414141),
      accent: const Color(0xFF191919),
      focus: const Color(0xFF4100AB),
      onFocus: const Color(0xFFEADEFF),
      window: const Color(0xFFFFFFFF),
      background: const Color(0xFFF9F5FF),
      backgroundTransparent: const Color(0x1FF9F5FF),
      divider: const Color(0x1AF9F5FF),
      item: const Color(0xFFFFFFFF),
      shadow: const Color(0xFFEBEBEB),
      placeholder: const Color(0xFFF9F9F9),
      label: const Color(0xFFEBEBEB));

  static final AppColors darkColorPalette = AppColors(
      primary: const Color(0xFFD3D3D3),
      primaryDark: const Color(0xFF6E6E6E),
      accent: const Color(0xFFF9F9F9),
      focus: const Color(0xFF874EFF),
      onFocus: const Color(0xFFEADEFF),
      window: const Color(0xFF010101),
      background: const Color(0xFF010101),
      backgroundTransparent: const Color(0x1F010101),
      divider: const Color(0x1A010101),
      item: const Color(0xFF1B1B1B),
      shadow: const Color(0xFF111111),
      placeholder: const Color(0xFF575757),
      label: const Color(0xFF575757));

  static var lightThemeData = ThemeData(
      primaryColor: lightColorPalette.primary,
      primaryColorDark: lightColorPalette.primaryDark,
      primaryColorLight: lightColorPalette.accent,
      focusColor: lightColorPalette.focus,
      hoverColor: lightColorPalette.onFocus,
      scaffoldBackgroundColor: lightColorPalette.background,
      backgroundColor: lightColorPalette.window,
      canvasColor: lightColorPalette.backgroundTransparent,
      dividerColor: lightColorPalette.divider,
      cardColor: lightColorPalette.item,
      shadowColor: lightColorPalette.shadow,
      splashColor: lightColorPalette.placeholder,
      hintColor: lightColorPalette.label,
      unselectedWidgetColor: lightColorPalette.primary,
      dialogBackgroundColor: lightColorPalette.item,
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(primary: lightColorPalette.accent)),
      colorScheme: ColorScheme.highContrastLight(
          primary: lightColorPalette.focus,
          onPrimary: lightColorPalette.onFocus),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: lightColorPalette.item,
          selectedIconTheme: IconThemeData(color: lightColorPalette.focus),
          unselectedIconTheme: IconThemeData(color: lightColorPalette.primary)),
      appBarTheme: AppBarTheme(
          centerTitle: true,
          backgroundColor: lightColorPalette.item,
          foregroundColor: lightColorPalette.accent,
          titleTextStyle: TextStyle(
              fontSize: ThemeDimens.fontSizeLarge,
              fontWeight: FontWeight.bold,
              fontFamily: "Avenir",
              color: lightColorPalette.accent)),
      progressIndicatorTheme: ProgressIndicatorThemeData(
          color: lightColorPalette.accent,
          refreshBackgroundColor: lightColorPalette.item),
      fontFamily: "Avenir",
      textTheme:
          // TextField text color
          TextTheme(subtitle1: TextStyle(color: lightColorPalette.accent)),
      inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(color: lightColorPalette.primary),
          enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent)),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent))),
      textSelectionTheme:
          TextSelectionThemeData(cursorColor: lightColorPalette.accent));

  static var darkThemeData = ThemeData(
      primaryColor: darkColorPalette.primary,
      primaryColorDark: darkColorPalette.primaryDark,
      primaryColorLight: darkColorPalette.accent,
      focusColor: darkColorPalette.focus,
      hoverColor: darkColorPalette.onFocus,
      scaffoldBackgroundColor: darkColorPalette.window,
      backgroundColor: darkColorPalette.background,
      canvasColor: darkColorPalette.backgroundTransparent,
      dividerColor: darkColorPalette.divider,
      cardColor: darkColorPalette.item,
      shadowColor: darkColorPalette.shadow,
      splashColor: darkColorPalette.placeholder,
      hintColor: darkColorPalette.label,
      unselectedWidgetColor: darkColorPalette.primary,
      dialogBackgroundColor: darkColorPalette.item,
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(primary: darkColorPalette.accent)),
      colorScheme: ColorScheme.highContrastDark(
          surface: darkColorPalette.focus,
          onSurface: darkColorPalette.onFocus,
          primary: darkColorPalette.focus,
          onPrimary: darkColorPalette.onFocus),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: darkColorPalette.item,
          selectedIconTheme: IconThemeData(color: darkColorPalette.focus),
          unselectedIconTheme: IconThemeData(color: darkColorPalette.primary)),
      appBarTheme: AppBarTheme(
          centerTitle: true,
          backgroundColor: darkColorPalette.item,
          foregroundColor: darkColorPalette.accent,
          titleTextStyle: TextStyle(
              fontSize: ThemeDimens.fontSizeLarge,
              fontWeight: FontWeight.bold,
              fontFamily: "Avenir",
              color: darkColorPalette.accent)),
      progressIndicatorTheme: ProgressIndicatorThemeData(
          color: darkColorPalette.accent,
          refreshBackgroundColor: darkColorPalette.item),
      fontFamily: "Avenir",
      textTheme:
          // TextField text color
          TextTheme(subtitle1: TextStyle(color: darkColorPalette.accent)),
      inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(color: darkColorPalette.primary),
          enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent)),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent))),
      textSelectionTheme:
          TextSelectionThemeData(cursorColor: darkColorPalette.accent));
}

class AppColors {
  Color primary;
  Color primaryDark;
  Color accent;
  Color focus;
  Color onFocus;
  Color window;
  Color background;
  Color backgroundTransparent;
  Color divider;
  Color item;
  Color shadow;
  Color placeholder;
  Color label;

  AppColors(
      {required this.primary,
      required this.primaryDark,
      required this.accent,
      required this.focus,
      required this.onFocus,
      required this.window,
      required this.background,
      required this.backgroundTransparent,
      required this.divider,
      required this.item,
      required this.shadow,
      required this.placeholder,
      required this.label});
}
