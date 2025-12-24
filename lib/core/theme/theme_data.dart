import 'package:flutter/material.dart';

class AppTheme {

  // ===== GRADIENTES =====

  /// ☀️ Dia
  static const LinearGradient dayBottomGradient = LinearGradient(
    colors: [
      Color(0xFF0F4C75),
      Color(0xFF1B6CA8),
    ],
  );

  static const LinearGradient dayNavigationGradient = LinearGradient(
    colors: [
      Color(0xFF0B3C5D),
      Color(0xFF092635),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  /// 🌆 Tarde
  static const LinearGradient afternoonBottomGradient = LinearGradient(
    colors: [
      Color(0xFFFFAB91),
      Color(0xFFFF8A65),
    ],
  );

  static const LinearGradient afternoonNavigationGradient = LinearGradient(
    colors: [
      Color(0xFF8D5524),
      Color(0xFF5D3A1A),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  /// 🌙 Noite
  static const LinearGradient nightBottomGradient = LinearGradient(
    colors: [
      Color(0xFF6A5ACD),
      Color(0xFF483D8B),
    ],
  );

  static const LinearGradient nightNavigationGradient = LinearGradient(
    colors: [
      Color(0xFF1B1035),
      Color(0xFF0F081F),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

