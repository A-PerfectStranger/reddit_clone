import 'package:flutter/material.dart';

/// Reemplaza imagenes reales por bloques de color con gradiente
/// determinista, para que la app funcione 100% sin conexion.
class ImagePlaceholder extends StatelessWidget {
  final String seed;
  final double? height;
  final BorderRadius? borderRadius;

  const ImagePlaceholder({
    super.key,
    required this.seed,
    this.height,
    this.borderRadius,
  });

  static const List<List<Color>> _gradients = [
    [Color(0xFFFF4500), Color(0xFFFFA07A)],
    [Color(0xFF0079D3), Color(0xFF66C2FF)],
    [Color(0xFF272729), Color(0xFF5A5A5C)],
    [Color(0xFF46D160), Color(0xFFB7F5C1)],
    [Color(0xFF7193FF), Color(0xFFD1DBFF)],
  ];

  int get _hash => seed.codeUnits.fold(0, (a, b) => a + b);

  @override
  Widget build(BuildContext context) {
    final colors = _gradients[_hash % _gradients.length];
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: Container(
        height: height ?? 220,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Icon(
            Icons.image_outlined,
            color: Colors.white.withValues(alpha: 0.6),
            size: 40,
          ),
        ),
      ),
    );
  }
}
