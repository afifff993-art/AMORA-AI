import 'dart:ui';

import 'package:flutter/material.dart';

/// Frosted-glass container used across AMORA screens.
class GlassCard extends StatelessWidget {
  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
  });

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = Theme.of(context).colorScheme.primary;
    final radius = BorderRadius.circular(20);
    return ClipRRect(
      borderRadius: radius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            borderRadius: radius,
            color: Colors.white.withOpacity(isDark ? 0.06 : 0.65),
            border: Border.all(color: accent.withOpacity(0.25)),
          ),
          child: child,
        ),
      ),
    );
  }
}
