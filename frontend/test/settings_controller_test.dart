import 'package:amora/core/settings/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  test('defaults to dark mode and full animation', () async {
    final s = await SettingsController.load();
    expect(s.themeMode, ThemeMode.dark);
    expect(s.animationIntensity, 1.0);
  });

  test('saved settings survive a reload', () async {
    final s = await SettingsController.load();
    await s.setThemeMode(ThemeMode.light);
    await s.setAnimationIntensity(0.5);

    final reloaded = await SettingsController.load();
    expect(reloaded.themeMode, ThemeMode.light);
    expect(reloaded.animationIntensity, 0.5);
  });

  test('animation intensity is clamped to 0..1', () async {
    final s = await SettingsController.load();
    await s.setAnimationIntensity(5);
    expect(s.animationIntensity, 1.0);
    await s.setAnimationIntensity(-2);
    expect(s.animationIntensity, 0.0);
  });
}
