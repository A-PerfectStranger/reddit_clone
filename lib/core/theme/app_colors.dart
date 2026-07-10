import 'package:flutter/material.dart';

/// Paleta de colores inspirada en la identidad visual de Reddit.
///
/// Reddit utiliza el naranja como color de marca (energía, entusiasmo,
/// llamado a la acción) combinado con una base neutra en blancos, negros
/// y grises que favorece la legibilidad de grandes volúmenes de texto
/// generado por usuarios (posts, comentarios).
class AppColors {
  AppColors._();

  // Color principal de marca.
  static const Color redditOrange = Color(0xFFFF4500);
  static const Color redditOrangeDark = Color(0xFFCC3700);

  // Color secundario (usado en Reddit para links, estados "unread", etc.)
  static const Color redditBlue = Color(0xFF0079D3);

  // Estados de voto.
  static const Color upvoteOrange = Color(0xFFFF4500);
  static const Color downvoteBlue = Color(0xFF7193FF);

  // Neutrales - modo claro.
  static const Color backgroundLight = Color(0xFFFFFFFF);
  static const Color surfaceLight = Color(0xFFF6F7F8);
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color dividerLight = Color(0xFFEDEFF1);
  static const Color textPrimaryLight = Color(0xFF1A1A1B);
  static const Color textSecondaryLight = Color(0xFF787C7E);

  // Neutrales - modo oscuro.
  static const Color backgroundDark = Color(0xFF030303);
  static const Color surfaceDark = Color(0xFF1A1A1B);
  static const Color cardDark = Color(0xFF1A1A1B);
  static const Color dividerDark = Color(0xFF343536);
  static const Color textPrimaryDark = Color(0xFFD7DADC);
  static const Color textSecondaryDark = Color(0xFF818384);

  // Paleta usada para generar avatares e íconos de comunidades de forma
  // determinista a partir de un índice (evita depender de imágenes reales).
  static const List<Color> avatarPalette = [
    Color(0xFFFF4500),
    Color(0xFF0079D3),
    Color(0xFF46D160),
    Color(0xFFFFB000),
    Color(0xFFFF66AC),
    Color(0xFF7193FF),
    Color(0xFF00A6A5),
    Color(0xFFFFD635),
    Color(0xFF94E044),
    Color(0xFFDDBD37),
    Color(0xFFEA0027),
    Color(0xFF24A0ED),
  ];

  static Color colorFromSeed(int seed) {
    return avatarPalette[seed % avatarPalette.length];
  }
}

extension ColorX on Color {
  Color withOpacityCompat(double opacity) => withValues(alpha: opacity);
}
