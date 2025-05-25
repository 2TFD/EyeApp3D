import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BrandTheme {
  ThemeData get darkTheme => ThemeData(

    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.black,
      brightness: Brightness.dark,
    ),
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(backgroundColor: Colors.black, titleTextStyle: TextStyle(color: Colors.white, fontSize: 20), surfaceTintColor: Colors.black),
    iconTheme: IconThemeData(color: Colors.white),
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        color: Colors.white,
        fontSize: 30,
      ),
      bodyMedium: TextStyle(
        color: Colors.white,
        fontSize: 15
      ),
      bodySmall: TextStyle(
        color: Colors.white,
        fontSize: 10
      )
    ),
  );
  

  ThemeData get lightTheme => ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.white,
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(backgroundColor: Colors.white, titleTextStyle: TextStyle(color: Colors.black, fontSize: 20)),
    iconTheme: IconThemeData(color: Colors.black),
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        color: Colors.black,
        fontSize: 30,
      ),
      bodyMedium: TextStyle(
        color: Colors.black,
        fontSize: 15
      ),
      bodySmall: TextStyle(
        color: Colors.black,
        fontSize: 10
      )
    ),
  );

}
