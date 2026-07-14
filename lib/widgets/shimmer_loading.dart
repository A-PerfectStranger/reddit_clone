import 'package:flutter/material.dart';

/// Simulacion de "Shimmer" (skeleton loading) usando solo
/// animaciones nativas de Flutter (AnimationController + Tween),
/// sin dependencias externas.
class ShimmerBox extends StatefulWidget {
  final double height;
  final double? width;
  final BorderRadius? borderRadius;

  const ShimmerBox({
    super.key,
    required this.height,
    this.width,
    this.borderRadius,
  });

  @override
  State<ShimmerBox> createState() => _ShimmerBoxState();
}

class _ShimmerBoxState extends State<ShimmerBox>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1200),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final base = Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFF272729)
        : const Color(0xFFE9EBEE);
    final highlight = Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFF3A3A3C)
        : const Color(0xFFF6F7F8);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          height: widget.height,
          width: widget.width ?? double.infinity,
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius ?? BorderRadius.circular(6),
            gradient: LinearGradient(
              colors: [base, highlight, base],
              stops: const [0.0, 0.5, 1.0],
              begin: Alignment(-1 + _controller.value * 2, 0),
              end: Alignment(1 + _controller.value * 2, 0),
            ),
          ),
        );
      },
    );
  }
}

class ShimmerPostCard extends StatelessWidget {
  const ShimmerPostCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ShimmerBox(
                  height: 32,
                  width: 32,
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              SizedBox(width: 8),
              ShimmerBox(height: 12, width: 120),
            ],
          ),
          SizedBox(height: 10),
          ShimmerBox(height: 16, width: 250),
          SizedBox(height: 8),
          ShimmerBox(height: 160),
        ],
      ),
    );
  }
}
