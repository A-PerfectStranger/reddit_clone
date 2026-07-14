import 'package:flutter/material.dart';

/// Avatar generado a partir de una "seed" (sin depender de red).
/// Usa un color y una inicial derivados de forma determinista del seed.
class AvatarPlaceholder extends StatelessWidget {
  final String seed;
  final double radius;

  const AvatarPlaceholder({super.key, required this.seed, this.radius = 18});

  static const List<Color> _palette = [
    Color(0xFFFF4500),
    Color(0xFF0079D3),
    Color(0xFF46D160),
    Color(0xFFFFB000),
    Color(0xFF7193FF),
    Color(0xFFFF66AC),
    Color(0xFF00A6A5),
    Color(0xFF94E044),
  ];

  int get _hash => seed.codeUnits.fold(0, (a, b) => a + b);

  @override
  Widget build(BuildContext context) {
    final color = _palette[_hash % _palette.length];
    final letter = seed.isNotEmpty ? seed[0].toUpperCase() : '?';
    return CircleAvatar(
      radius: radius,
      backgroundColor: color,
      child: Text(
        letter,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: radius * 0.8,
        ),
      ),
    );
  }
}
