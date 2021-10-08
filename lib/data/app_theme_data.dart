import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum AppTheme { lightTheme, darkTheme }

class AppThemes {
  static final appThemeData = {
    AppTheme.lightTheme: ThemeData(
      primarySwatch: Colors.grey,
      primaryColor: Colors.white,
      brightness: Brightness.light,
      backgroundColor: const Color(0xFFE5E5E5),
      accentColor: Colors.black,
      iconTheme: IconThemeData(color: Colors.black),
      dividerColor: Colors.white54,
      textTheme: TextTheme(

        bodyText1: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        bodyText2: TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.bold,
            fontSize: 28,
        ),

      ),
    ),
    AppTheme.darkTheme: ThemeData(
      primarySwatch: Colors.grey,
      primaryColor: Colors.black,
      brightness: Brightness.dark,
      backgroundColor: const Color(0xFF212121),
      accentColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.white),
      dividerColor: Colors.black12,
      textTheme:TextTheme(
        headline1: TextStyle(

        ),
        bodyText1: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 24,

        ),
        bodyText2: TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
            fontSize: 28
        ),
      ),
    ),
  };
}
