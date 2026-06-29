import 'package:flutter/material.dart';

class AvatarUtils {
  static const List<Color> backgroundColors = [
    Color(0xFFEFF6FF),
    Color(0xFFFEF3C7),
    Color(0xFFFEE2E2),
    Color(0xFFECFDF5),
    Color(0xFFF5F3FF),
  ];

  static const List<Color> textColors = [
    Color(0xFF1E40AF),
    Color(0xFF92400E),
    Color(0xFF991B1B),
    Color(0xFF065F46),
    Color(0xFF5B21B6),
  ];

  static Color background(int id) => backgroundColors[id % backgroundColors.length];
  static Color text(int id) => textColors[id % textColors.length];

  static String initials(String name) {
    if (name.isEmpty) return '??';
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.length > 1) {
      return (parts[0][0] + parts[1][0]).toUpperCase();
    }
    return parts[0][0].toUpperCase();
  }
}
