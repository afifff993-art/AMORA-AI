import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Stores user settings locally on the device (no network involved).
class SettingsController extends ChangeNotifier {
  SettingsController._(this._prefs)
      : _themeMode = _readThemeMode(_prefs),
        _animationIntensity = _readIntensity(_prefs);

  static const _kThemeMode = 'theme_mode';
  static const _kAnimationIntensity = 'animation_intensity';

  final SharedPreferences _prefs;
  ThemeMode _themeMode;
  double _animationIntensity;

  /// Loads saved settings. Call once before runApp.
  static Future<SettingsController> load() async {
    final prefs = await SharedPreferences.getInstance();
    return SettingsController._(prefs);
  }

  ThemeMode get themeMode => _themeMode;

  /// 0.0 = animations off (static orb), 1.0 = full intensity.
  double get animationIntensity => _animationIntensity;

  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    notifyListeners();
    await _prefs.setString(_kThemeMode, mode.name);
  }

  Future<void> setAnimationIntensity(double value) async {
    _animationIntensity = value.clamp(0.0, 1.0).toDouble();
    notifyListeners();
    await _prefs.setDouble(_kAnimationIntensity, _animationIntensity);
  }

  static ThemeMode _readThemeMode(SharedPreferences prefs) {
    final saved = prefs.getString(_kThemeMode);
    return ThemeMode.values.firstWhere(
      (m) => m.name == saved,
      orElse: () => ThemeMode.dark,
    );
  }

  static double _readIntensity(SharedPreferences prefs) {
    final saved = prefs.getDouble(_kAnimationIntensity);
    return (saved ?? 1.0).clamp(0.0, 1.0).toDouble();
  }
}
