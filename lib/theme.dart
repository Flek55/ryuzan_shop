import 'package:flutter/material.dart';
ThemeData theme(){
  return ThemeData(
        colorScheme: const ColorScheme(
            brightness: Brightness.light,
            primary: Colors.black87,
            onPrimary: Colors.white,
            secondary: Colors.white,
            onSecondary: Colors.white,
            tertiary: Colors.grey,
            error: Colors.red,
            onError: Colors.red ,
            surface: Colors.white,
            onSurface: Colors.white
        ),

        textTheme: const TextTheme(
          displayLarge: TextStyle(
              color: Colors.black, fontWeight: FontWeight.normal, fontSize: 26,fontFamily: 'Roboto'),
          displayMedium: TextStyle(
              color: Colors.black, fontWeight: FontWeight.normal, fontSize: 20,fontFamily: 'Roboto'),
          displaySmall: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16,fontFamily: 'Roboto'),
          titleLarge: TextStyle(
              fontFamily: 'Roboto', fontSize: 25, color: Colors.white),
          titleMedium: TextStyle(
              fontFamily: 'Roboto', fontSize: 13, color: Color(0xFF707B7C)),
        ));
  }

