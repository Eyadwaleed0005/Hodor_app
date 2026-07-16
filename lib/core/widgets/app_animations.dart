import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AppAnimations {
  AppAnimations._();

  static List<Effect<dynamic>> fadeSlideUp({
    Duration? delay,
    Duration duration = const Duration(milliseconds: 450),
  }) {
    return [
      FadeEffect(
        delay: delay ?? Duration.zero,
        duration: duration,
        curve: Curves.easeOutCubic,
      ),
      SlideEffect(
        delay: delay ?? Duration.zero,
        duration: duration,
        begin: const Offset(0, .12),
        end: Offset.zero,
        curve: Curves.easeOutCubic,
      ),
    ];
  }

  static List<Effect<dynamic>> fadeScale({
    Duration? delay,
    Duration duration = const Duration(milliseconds: 450),
  }) {
    return [
      FadeEffect(
        delay: delay ?? Duration.zero,
        duration: duration,
        curve: Curves.easeOutCubic,
      ),
      ScaleEffect(
        delay: delay ?? Duration.zero,
        duration: duration,
        begin: const Offset(.96, .96),
        end: const Offset(1, 1),
        curve: Curves.easeOutCubic,
      ),
    ];
  }

  static List<Effect<dynamic>> fadeSlideRight({
    Duration? delay,
    Duration duration = const Duration(milliseconds: 450),
  }) {
    return [
      FadeEffect(
        delay: delay ?? Duration.zero,
        duration: duration,
        curve: Curves.easeOutCubic,
      ),
      SlideEffect(
        delay: delay ?? Duration.zero,
        duration: duration,
        begin: const Offset(.12, 0),
        end: Offset.zero,
        curve: Curves.easeOutCubic,
      ),
    ];
  }
}