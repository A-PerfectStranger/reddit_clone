import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';

/// Widget de "esqueleto de carga" (loading skeleton) genérico.
///
/// Anima suavemente la opacidad de un bloque de color para simular el
/// efecto shimmer típico mientras el contenido real se está cargando,
/// sin depender de paquetes externos.
class LoadingSkeleton extends StatefulWidget {
  final double width;
  final double height;
  final BorderRadius borderRadius;

  const LoadingSkeleton({
    super.key,
    this.width = double.infinity,
    this.height = 16,
    this.borderRadius = const BorderRadius.all(Radius.circular(6)),
  });

  @override
  State<LoadingSkeleton> createState() => _LoadingSkeletonState();
}

class _LoadingSkeletonState extends State<LoadingSkeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.35, end: 0.9).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Opacity(
          opacity: _animation.value,
          child: Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              color: AppColors.dividerLight,
              borderRadius: widget.borderRadius,
            ),
          ),
        );
      },
    );
  }
}

/// Tarjeta esqueleto que imita la silueta de un [PostCard], usada mientras
/// el feed principal está cargando por primera vez.
class PostCardSkeleton extends StatelessWidget {
  const PostCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Row(
              children: [
                LoadingSkeleton(
                  width: 32,
                  height: 32,
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                SizedBox(width: 8),
                LoadingSkeleton(width: 140, height: 12),
              ],
            ),
            SizedBox(height: 12),
            LoadingSkeleton(height: 14),
            SizedBox(height: 6),
            LoadingSkeleton(width: 220, height: 14),
            SizedBox(height: 12),
            LoadingSkeleton(height: 140, borderRadius: BorderRadius.all(Radius.circular(10))),
            SizedBox(height: 12),
            LoadingSkeleton(height: 24, width: 180),
          ],
        ),
      ),
    );
  }
}
