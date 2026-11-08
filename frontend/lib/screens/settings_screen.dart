import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/settings/settings_controller.dart';
import '../widgets/glass_card.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static String _intensityLabel(double v) {
    if (v == 0) return 'Off (static orb)';
    if (v <= 0.5) return 'Low';
    if (v < 1) return 'Medium';
    return 'Full';
  }

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsController>();
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Appearance', style: textTheme.titleMedium),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: SegmentedButton<ThemeMode>(
                    segments: const [
                      ButtonSegment(
                        value: ThemeMode.system,
                        label: Text('System'),
                        icon: Icon(Icons.brightness_auto),
                      ),
                      ButtonSegment(
                        value: ThemeMode.dark,
                        label: Text('Dark'),
                        icon: Icon(Icons.dark_mode),
                      ),
                      ButtonSegment(
                        value: ThemeMode.light,
                        label: Text('Light'),
                        icon: Icon(Icons.light_mode),
                      ),
                    ],
                    selected: {settings.themeMode},
                    onSelectionChanged: (s) => settings.setThemeMode(s.first),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Animation intensity', style: textTheme.titleMedium),
                Text(
                  _intensityLabel(settings.animationIntensity),
                  style: textTheme.bodySmall,
                ),
                Slider(
                  value: settings.animationIntensity,
                  divisions: 4,
                  label: _intensityLabel(settings.animationIntensity),
                  onChanged: settings.setAnimationIntensity,
                ),
                Text(
                  'Lower values save battery. Off shows a still core.',
                  style: textTheme.bodySmall,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          GlassCard(
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.info_outline),
              title: const Text('AMORA'),
              subtitle: const Text('Version 0.1.0 (Phase 1: foundation + UI)'),
            ),
          ),
        ],
      ),
    );
  }
}
