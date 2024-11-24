import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ThemeCubit extends HydratedCubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system);

  //Este metodo toma el tema por paramtetro y lo inserta en el estado ThemeMode
  void updateTheme(ThemeMode themeMode) => emit(themeMode);

  @override
  ThemeMode? fromJson(Map<String, dynamic> json) {
    return null;

    // TODO: implement fromJson
  }

  @override
  Map<String, dynamic>? toJson(ThemeMode state) {
    return null;

    // TODO: implement toJson
  }
}
