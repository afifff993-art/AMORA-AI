import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../core/models/orb_state.dart';
import '../core/theme/amora_colors.dart';

/// The animated AMORA AI core (original design, drawn with CustomPainter).
///
/// Phase 1 note: the waveform in LISTENING/SPEAKING is a synthetic animation.
/// It is wired to real microphone/speech levels in Phase 3.
class AiCoreOrb extends StatefulWidget {
  const AiCoreOrb({
    super.key,
    required this.state,
    required this.intensity,
    this.size = 280,
  });

  final OrbState state;

  /// 0.0 (static) to 1.0 (full motion).
  final double intensity;
  final double size;

  @override
  State<AiCoreOrb> createState() => _AiCoreOrbState();
}

class _AiCoreOrbState extends State<AiCoreOrb>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 12),
  );

  @override
  void initState() {
    super.initState();
    _syncAnimation();
  }

  @override
  void didUpdateWidget(covariant AiCoreOrb oldWidget) {
    super.didUpdateWidget(oldWidget);
    _syncAnimation();
  }

  void _syncAnimation() {
    if (widget.intensity > 0) {
      if (!_controller.isAnimating) _controller.repeat();
    } else {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Semantics(
      label: 'AMORA AI core, ${widget.state.label}',
      child: SizedBox(
        width: widget.size,
        height: widget.size,
        child: RepaintBoundary(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, _) => CustomPaint(
              painter: _OrbPainter(
                t: _controller.value,
                state: widget.state,
                intensity: widget.intensity,
                accent: scheme.primary,
                secondary: scheme.secondary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _OrbPainter extends CustomPainter {
  _OrbPainter({
    required this.t,
    required this.state,
    required this.intensity,
    required this.accent,
    required this.secondary,
  });

  final double t; // 0..1, loops every 12 s
  final OrbState state;
  final double intensity;
  final Color accent;
  final Color secondary;

  static const double _tau = math.pi * 2;

  /// Integer speed multipliers keep the 12 s loop seamless.
  int get _speed {
    switch (state) {
      case OrbState.idle:
        return 1;
      case OrbState.listening:
        return 2;
      case OrbState.thinking:
        return 6;
      case OrbState.speaking:
        return 3;
      case OrbState.error:
        return 0;
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final c = size.center(Offset.zero);
    final r = size.shortestSide / 2;
    final base = state == OrbState.error ? AmoraColors.error : accent;
    final pulseSpeed = state == OrbState.error ? 6 : 2;
    final pulse = 0.5 + 0.5 * math.sin(t * _tau * pulseSpeed);

    // Soft outer glow.
    final glowRect = Rect.fromCircle(center: c, radius: r);
    canvas.drawCircle(
      c,
      r,
      Paint()
        ..shader = RadialGradient(colors: [
          base.withOpacity(0.30 + 0.20 * pulse * intensity),
          base.withOpacity(0.0),
        ]).createShader(glowRect),
    );

    // Core sphere.
    final coreR = r * 0.40 * (1 + 0.04 * pulse * intensity);
    canvas.drawCircle(
      c,
      coreR,
      Paint()
        ..shader = RadialGradient(
          center: const Alignment(-0.3, -0.3),
          colors: [
            Colors.white.withOpacity(0.9),
            base,
            (state == OrbState.error ? AmoraColors.error : secondary)
                .withOpacity(0.8),
            AmoraColors.black,
          ],
          stops: const [0.0, 0.25, 0.7, 1.0],
        ).createShader(Rect.fromCircle(center: c, radius: coreR)),
    );

    // Dashed HUD rings, each rotating at a different rate.
    final spin = t * _tau * _speed;
    _dashedRing(canvas, c, r * 0.58, spin, base.withOpacity(0.7), 24, 2.0);
    _dashedRing(canvas, c, r * 0.68, -spin * 0.5, secondary.withOpacity(0.6), 36, 1.5);

    // Thinking: rotating sweep arc.
    if (state == OrbState.thinking) {
      final rect = Rect.fromCircle(center: c, radius: r * 0.88);
      canvas.drawArc(
        rect,
        0,
        _tau,
        false,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 4
          ..strokeCap = StrokeCap.round
          ..shader = SweepGradient(
            colors: [base.withOpacity(0.0), base],
            stops: const [0.4, 1.0],
            transform: GradientRotation(spin),
          ).createShader(rect),
      );
    }

    // Outer ring: waveform bars (listening / speaking) or static ticks.
    const bars = 64;
    final inner = r * 0.76;
    final barPaint = Paint()
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round
      ..color = base;
    for (var i = 0; i < bars; i++) {
      final angle = i / bars * _tau;
      double length;
      if (state == OrbState.listening) {
        final level = 0.35 +
            0.65 *
                (math.sin(i * 0.9 + t * _tau * 6) *
                        math.sin(i * 0.3 - t * _tau * 3))
                    .abs();
        length = 3 + r * 0.16 * level * intensity;
      } else if (state == OrbState.speaking) {
        final level = 0.3 + 0.7 * math.sin(i * 0.5 + t * _tau * 4).abs();
        length = 3 + r * 0.14 * level * intensity;
      } else {
        length = 3;
        barPaint.color = base.withOpacity(0.3);
      }
      if (state == OrbState.listening || state == OrbState.speaking) {
        barPaint.color = base.withOpacity(0.9);
      }
      final dir = Offset(math.cos(angle), math.sin(angle));
      canvas.drawLine(c + dir * inner, c + dir * (inner + length), barPaint);
    }
  }

  void _dashedRing(Canvas canvas, Offset c, double radius, double rotation,
      Color color, int dashes, double width) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = width
      ..strokeCap = StrokeCap.round
      ..color = color;
    final rect = Rect.fromCircle(center: c, radius: radius);
    final step = _tau / dashes;
    for (var i = 0; i < dashes; i++) {
      canvas.drawArc(rect, rotation + i * step, step * 0.55, false, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _OrbPainter old) => true;
}
