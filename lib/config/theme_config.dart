import 'package:flutter/material.dart';
import 'package:todo_app/constants/config_constant.dart';

const Color _primaryColorLight = Color(0xFFFFFFFF);
const Color _primaryColorDark = Color(0xFF191B20);
const Color _primaryRedColor = Color(0xFFD20000);
const Color _greySecondary = Color(0xFFF1F1F1);
const Color _greyPrimary = Color(0xFFDBDCDC);
const Color _primaryColor = Color(0xFF027EFF);

class ThemeConfig {
  final bool darkMode;
  ThemeConfig({this.darkMode = false});

  ThemeData get theme {
    return this.darkMode ? _dark : _light;
  }

  ThemeData get _light {
    final TextTheme _textThemeData = _textTheme.apply(
      decorationColor: _primaryColorDark,
      displayColor: _primaryColorDark,
      bodyColor: _primaryColorDark,
    );

    final AppBarTheme _appBarThemeData = AppBarTheme(
      elevation: 0.5,
      titleSpacing: 0.0,
      color: _primaryColorLight,
      textTheme: _textThemeData,
      titleTextStyle: _textThemeData.bodyText1,
      iconTheme: IconThemeData(
        color: _primaryColorDark,
        size: ConfigConstant.size4,
      ),
    );

    return ThemeData(
      textTheme: _textThemeData,
      dividerColor: _greyPrimary,
      primaryColor: _primaryColor,
      brightness: Brightness.light,
      errorColor: _primaryRedColor,
      appBarTheme: _appBarThemeData,
      disabledColor: _greySecondary,
      splashColor: Colors.transparent,
      backgroundColor: _primaryColorLight,
      primaryColorDark: _primaryColorDark,
      primaryColorLight: _primaryColorLight,
      scaffoldBackgroundColor: _greySecondary,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  ThemeData get _dark {
    final TextTheme _textThemeData = _textTheme.apply();
    return ThemeData(
      brightness: Brightness.dark,
      textTheme: _textThemeData,
    );
  }

  TextTheme get _textTheme {
    final List<String> fontFamilyFallback = ["Kantumruy", "Quicksand"];

    return TextTheme(
      headline1: TextStyle(
        fontFamilyFallback: fontFamilyFallback,
      ),
      headline2: TextStyle(
        fontFamilyFallback: fontFamilyFallback,
      ),
      headline3: TextStyle(
        fontFamilyFallback: fontFamilyFallback,
      ),
      headline4: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        fontFamilyFallback: fontFamilyFallback,
      ),
      headline5: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        fontFamilyFallback: fontFamilyFallback,
      ),
      headline6: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        fontFamilyFallback: fontFamilyFallback,
      ),
      subtitle1: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        fontFamilyFallback: fontFamilyFallback,
      ),
      subtitle2: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        fontFamilyFallback: fontFamilyFallback,
      ),
      bodyText1: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        fontFamilyFallback: fontFamilyFallback,
      ),
      bodyText2: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        fontFamilyFallback: fontFamilyFallback,
      ),
      button: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        fontFamilyFallback: fontFamilyFallback,
      ),
      caption: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        fontFamilyFallback: fontFamilyFallback,
      ),
      overline: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        fontFamilyFallback: fontFamilyFallback,
      ),
    );
  }
}
