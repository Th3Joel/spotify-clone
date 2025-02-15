import 'package:flutter/material.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';

class AppTheme{
  static final lightTheme = ThemeData(
    primaryColor: AppColors.primary,
    fontFamily: 'Satoshi',
      inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.transparent,
          hintStyle: const TextStyle(
            color: Color(0xff383838),
            fontWeight: FontWeight.w500
          ),
          contentPadding: const EdgeInsets.all(25),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(
                  color: Colors.black,
                  width: 0.4
              )
          )
      ),
    scaffoldBackgroundColor: AppColors.lightBackground,
    brightness: Brightness.light,//Para facilitar la lectura del tipo de letra
    //Para el boton en general
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: AppColors.primary,
        textStyle: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30)
        )
      )
    )
  );

  static final darkTheme = ThemeData(
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.darkBackground,
      fontFamily: 'Satoshi',
      inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.transparent,
          hintStyle: const TextStyle(
              color: Color(0xffA7A7A7),
              fontWeight: FontWeight.w500
          ),
          contentPadding: const EdgeInsets.all(25),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              color: Colors.white,
              width: 0.4
            )
          )
      ),
      brightness: Brightness.dark,//Para facilitar la lectura del tipo de letra
      //Para el boton en general
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
              backgroundColor: AppColors.primary,
              textStyle: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)
              )
          )
      )
  );
}