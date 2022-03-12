import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:store/shared/style/colors.dart';

ThemeData themeDark = ThemeData(
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: HexColor("333739"),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      color: Colors.white,
      fontSize: 16.6,
      fontWeight: FontWeight.bold,
    ),
    bodyText2: TextStyle(
      color: Colors.grey,
      fontSize: 16.6,
    ),
  ),
  appBarTheme: AppBarTheme(
    color: HexColor("333739"),
    elevation: 0.0,
    backwardsCompatibility: false,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor("333739"),
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    elevation: 50.0,
    backgroundColor: HexColor("333739"),
    unselectedItemColor: Colors.grey,
    unselectedIconTheme: IconThemeData(
      color: Colors.grey,
    ),
  ),
);
