import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_theme.dart';

class ThemeCubit extends Cubit<ThemeData> {
  final SharedPreferences _prefs;
  static const String _themeKey = 'selected_theme_index';

  // By default, set the dark theme, but immediately try to load the saved
  ThemeCubit(this._prefs) : super(AppThemes.darkTheme) {
    _loadTheme();
  }

  void _loadTheme() {
    final themeIndex = _prefs.getInt(_themeKey) ?? AppThemeType.dark.index;
    final themeType = AppThemeType.values[themeIndex];

    emit(AppThemes.getTheme(themeType));
  }

  Future<void> changeTheme(AppThemeType type) async {
    await _prefs.setInt(_themeKey, type.index);
    emit(AppThemes.getTheme(type));
  }
}