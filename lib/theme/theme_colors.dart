import 'package:flutter/material.dart';
import 'package:playflutter/theme/theme_dimens.dart';

/// @author jv.lee
/// @date 2022/4/27
/// @description 项目主题颜色
class ThemeColors {
  static final AppColors lightColorPalette = AppColors(
      const Color(0xFF9B9B9B),
      const Color(0xFF414141),
      const Color(0xFF191919),
      const Color(0xFF4100AB),
      const Color(0xFFEADEFF),
      const Color(0xFFFFFFFF),
      const Color(0xFFF9F5FF),
      const Color(0x1FF9F5FF),
      const Color(0x1AF9F5FF),
      const Color(0xFFFFFFFF),
      const Color(0xFFEBEBEB),
      const Color(0xFFF9F9F9),
      const Color(0xFFEBEBEB));

  static final AppColors darkColorPalette = AppColors(
      const Color(0xFFD3D3D3),
      const Color(0xFF6E6E6E),
      const Color(0xFFF9F9F9),
      const Color(0xFF874EFF),
      const Color(0xFFEADEFF),
      const Color(0xFF010101),
      const Color(0xFF010101),
      const Color(0x1F010101),
      const Color(0x1A010101),
      const Color(0xFF1B1B1B),
      const Color(0xFF111111),
      const Color(0xFF575757),
      const Color(0xFF575757));

  static var lightThemeData = ThemeData(
    primaryColor: lightColorPalette.primary,
    primaryColorDark: lightColorPalette.primaryDark,
    primaryColorLight: lightColorPalette.accent,
    focusColor: lightColorPalette.focus,
    hoverColor: lightColorPalette.onFocus,
    scaffoldBackgroundColor: lightColorPalette.background,
    backgroundColor: lightColorPalette.background,
    canvasColor: lightColorPalette.backgroundTransparent,
    dividerColor: lightColorPalette.divider,
    cardColor: lightColorPalette.item,
    shadowColor: lightColorPalette.shadow,
    splashColor: lightColorPalette.placeholder,
    hintColor: lightColorPalette.label,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: lightColorPalette.item,
        selectedIconTheme: IconThemeData(color: lightColorPalette.focus),
        unselectedIconTheme: IconThemeData(color: lightColorPalette.primary)),
    appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: lightColorPalette.item,
        foregroundColor: lightColorPalette.accent,
        titleTextStyle: TextStyle(
            fontSize: ThemeDimens.font_size_large,
            fontWeight: FontWeight.bold,
            fontFamily: "Avenir",
            color: lightColorPalette.accent)),
    progressIndicatorTheme: ProgressIndicatorThemeData(
        color: lightColorPalette.accent,
        refreshBackgroundColor: lightColorPalette.item),
    fontFamily: "Avenir",
    inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: lightColorPalette.primary),
        enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent)),
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent))),
    textSelectionTheme: TextSelectionThemeData(cursorColor: lightColorPalette.accent)
  );

  static var darkThemeData = ThemeData(
    primaryColor: darkColorPalette.primary,
    primaryColorDark: darkColorPalette.primaryDark,
    primaryColorLight: darkColorPalette.accent,
    focusColor: darkColorPalette.focus,
    hoverColor: darkColorPalette.onFocus,
    scaffoldBackgroundColor: darkColorPalette.background,
    backgroundColor: darkColorPalette.background,
    canvasColor: darkColorPalette.backgroundTransparent,
    dividerColor: darkColorPalette.divider,
    cardColor: darkColorPalette.item,
    shadowColor: darkColorPalette.shadow,
    splashColor: darkColorPalette.placeholder,
    hintColor: darkColorPalette.label,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: darkColorPalette.item,
        selectedIconTheme: IconThemeData(color: darkColorPalette.focus),
        unselectedIconTheme: IconThemeData(color: darkColorPalette.primary)),
    appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: darkColorPalette.item,
        foregroundColor: darkColorPalette.accent,
        titleTextStyle: TextStyle(
            fontSize: ThemeDimens.font_size_large,
            fontWeight: FontWeight.bold,
            fontFamily: "Avenir",
            color: darkColorPalette.accent)),
    progressIndicatorTheme: ProgressIndicatorThemeData(
        color: darkColorPalette.accent,
        refreshBackgroundColor: darkColorPalette.item),
    fontFamily: "Avenir",
    inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: darkColorPalette.primary),
        enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent)),
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent))),
      textSelectionTheme: TextSelectionThemeData(cursorColor: darkColorPalette.accent)
  );
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
      this.primary,
      this.primaryDark,
      this.accent,
      this.focus,
      this.onFocus,
      this.window,
      this.background,
      this.backgroundTransparent,
      this.divider,
      this.item,
      this.shadow,
      this.placeholder,
      this.label);
}
