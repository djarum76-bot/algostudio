import 'package:flutter/material.dart';

class AppTheme{
  static ThemeData theme(){
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: scaffoldColor,
      primarySwatch: createMaterialColor(primaryColor),
      colorScheme: ColorScheme.fromSwatch(
          primarySwatch: createMaterialColor(primaryColor)
      ),
    );
  }

  static ButtonStyle elevatedButton(double radius, Color color){
    return ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        )
    );
  }

  static Color primaryColor = const Color(0xFF216AD7);
  static Color iconColor = const Color(0xFFfefefe);
  static Color scaffoldColor = const Color(0xFFFFFFFF);
  static Color hintColor = const Color(0xFFC7C7C7);

  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    final swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }
}