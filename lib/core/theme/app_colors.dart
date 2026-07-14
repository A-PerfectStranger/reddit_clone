import 'package:flutter/material.dart';

/// Paleta de colores inspirada en la identidad visual de Reddit.
/// El naranja (#FF4500) es el color de marca ("Reddit Orange"),
/// usado como acento de energia y llamado a la accion.
class AppColors {
  AppColors._();

  static const Color redditOrange = Color(0xFFFF4500);
  static const Color redditOrangeLight = Color(0xFFFF5722);
  static const Color redditBlue = Color(0xFF0079D3);

  // Light theme
  static const Color lightBackground = Color(0xFFFFFFFF);
  static const Color lightSurface = Color(0xFFF6F7F8);
  static const Color lightBorder = Color(0xFFEDEFF1);
  static const Color lightTextPrimary = Color(0xFF1A1A1B);
  static const Color lightTextSecondary = Color(0xFF787C7E);

  // Dark theme
  static const Color darkBackground = Color(0xFF030303);
  static const Color darkSurface = Color(0xFF1A1A1B);
  static const Color darkCard = Color(0xFF272729);
  static const Color darkBorder = Color(0xFF343536);
  static const Color darkTextPrimary = Color(0xFFD7DADC);
  static const Color darkTextSecondary = Color(0xFF818384);

  static const Color upvote = redditOrange;
  static const Color downvote = Color(0xFF7193FF);
  static const Color success = Color(0xFF46D160);
  static const Color unreadDot = redditOrange;
}
