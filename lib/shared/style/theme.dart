import 'package:flutter/material.dart';
import 'package:shopapp/shared/constant.dart';

ThemeData lightTheme = ThemeData(
  primarySwatch: Colors.orange,
  fontFamily: "shop",
  floatingActionButtonTheme:
      const FloatingActionButtonThemeData(backgroundColor: mainColor),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white24,
    selectedItemColor: mainColor,
    unselectedLabelStyle: TextStyle(
      color: Colors.grey,
      fontSize: 18.0
    ),
    elevation: 5.0,
    unselectedItemColor: Colors.grey,
    type: BottomNavigationBarType.shifting,
  ),
  appBarTheme: const AppBarTheme(
    elevation: 0.0,
    backgroundColor: Colors.white24,
    titleTextStyle: TextStyle(
      color: mainColor,
      fontSize: 20.0,
    ),
    actionsIconTheme: IconThemeData(
      color: mainColor,
    ),
  ),
);
