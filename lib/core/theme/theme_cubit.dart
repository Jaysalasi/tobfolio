import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ThemeMode { light, dark, system }

class ThemeState extends Equatable {
  final ThemeMode themeMode;

  const ThemeState({this.themeMode = ThemeMode.light});

  ThemeState copyWith({ThemeMode? themeMode}) {
    return ThemeState(themeMode: themeMode ?? this.themeMode);
  }

  @override
  List<Object> get props => [themeMode];
}

class ThemeCubit extends Cubit<ThemeState> {
  static const String _themeKey = 'theme_mode';
  
  ThemeCubit() : super(const ThemeState()) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedTheme = prefs.getString(_themeKey);
      
      if (savedTheme != null) {
        final themeMode = ThemeMode.values.firstWhere(
          (mode) => mode.name == savedTheme,
          orElse: () => ThemeMode.light,
        );
        emit(state.copyWith(themeMode: themeMode));
      }
    } catch (e) {
      // Keep default theme if loading fails
    }
  }

  Future<void> setTheme(ThemeMode themeMode) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_themeKey, themeMode.name);
      emit(state.copyWith(themeMode: themeMode));
    } catch (e) {
      // Handle error if needed
    }
  }

  void toggleTheme() {
    final newTheme = state.themeMode == ThemeMode.light 
        ? ThemeMode.dark 
        : ThemeMode.light;
    setTheme(newTheme);
  }
}
