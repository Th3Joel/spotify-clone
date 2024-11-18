import 'package:flutter/material.dart';

//Esto agrega funcionalidad a contextp sin necesidad de heredar o instanciar una clase
extension DarkMode on BuildContext{
  bool get isDarkMode{
    return Theme.of(this).brightness == Brightness.dark;
  }
}