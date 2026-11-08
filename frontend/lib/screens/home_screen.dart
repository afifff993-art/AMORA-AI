import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/models/orb_state.dart';
import '../core/settings/settings_controller.dart';
import '../core/theme/amora_colors.dart';
import '../widgets/ai_core_orb.dart';
import '../widgets/glass_card.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  OrbState _preview = OrbState.idle;

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsController>();
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: const Alignment(0, -0.4),
            radius: 1.2,
            colors: isDark
                ? const [Color(0xFF0A1B33), AmoraColors.black]
                : const [Color(0xFFE3F1FF), AmoraColors.lightBackground],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final orbSize =
                  (constraints.maxWidth * 0.8).clamp(200.0, 340.0).toDouble();
              return ListView(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'AMORA',
                              style: theme.textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                                letterSpacing: 6,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                            Text(
                              'Advanced Multilingual Omni-purpose Responsive Assistant',
                              style: theme.textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        tooltip: 'Settings',
                        icon: const Icon(Icons.settings_outlined),
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (_) => const SettingsScreen(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: AiCoreOrb(
                      state: _preview,
                      intensity: settings.animationIntensity,
                      size: orbSize,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _preview.label,
                    key: const Key('orb-state-label'),
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleLarge,
                  ),
                  Text(
                    _preview.description,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodySmall,
                  ),
                  const SizedBox(height: 20),
                  GlassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Animation preview',
                            style: theme.textTheme.titleMedium),
                        const SizedBox(height: 4),
                        Text(
                          'These chips only preview the visual states. '
                          'Real listening and thinking arrive with voice '
                          '(Phase 3) and AI chat (Phase 2).',
                          style: theme.textTheme.bodySmall,
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            for (final s in OrbState.values)
                              ChoiceChip(
                                label: Text(s.label),
                                selected: _preview == s,
                                onSelected: (_) =>
                                    setState(() => _preview = s),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  GlassCard(
                    child: Row(
                      children: [
                        Icon(Icons.cloud_off, color: theme.colorScheme.error),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Backend: not connected',
                                  style: theme.textTheme.titleSmall),
                              Text(
                                'No AI backend exists yet. It is built in Phase 2.',
                                style: theme.textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
