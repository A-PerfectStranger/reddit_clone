import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';

/// Delegate que permite anclar (pin) la barra de búsqueda en la parte
/// superior del feed usando un [SliverPersistentHeader].
///
/// Esta es la implementación de la MEJORA DE UX propuesta: una barra de
/// búsqueda siempre visible que filtra el feed en tiempo real, evitando
/// que el usuario tenga que navegar a otra pantalla o hacer scroll hacia
/// arriba para buscar contenido.
class PersistentSearchBarDelegate extends SliverPersistentHeaderDelegate {
  final ValueChanged<String> onChanged;
  final TextEditingController controller;

  PersistentSearchBarDelegate({
    required this.onChanged,
    required this.controller,
  });

  @override
  double get minExtent => 64;

  @override
  double get maxExtent => 64;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: AppColors.backgroundLight,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      alignment: Alignment.center,
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: 'Buscar en tu feed...',
          prefixIcon: const Icon(Icons.search, size: 20),
          suffixIcon: controller.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, size: 18),
                  onPressed: () {
                    controller.clear();
                    onChanged('');
                  },
                )
              : null,
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant PersistentSearchBarDelegate oldDelegate) {
    return oldDelegate.controller.text != controller.text;
  }
}
