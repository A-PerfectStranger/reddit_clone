import 'package:flutter/material.dart';

/// MEJORA PROPUESTA DEL TALLER:
/// Barra de busqueda persistente que se mantiene fija en la parte
/// superior del feed (a diferencia de la app original de Reddit,
/// donde la busqueda esta dentro de un AppBar que se puede ocultar
/// segun la pantalla). Filtra publicaciones en tiempo real.
///
/// Implementada como un SliverPersistentHeader delegate para que
/// permanezca "pinned" durante el scroll, ver ANALISIS.md para la
/// justificacion tecnica y de UX.
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
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      color: theme.scaffoldBackgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Container(
        height: 44,
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF272729) : const Color(0xFFF6F7F8),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: theme.colorScheme.primary.withValues(alpha: 0.5),
          ),
        ),
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: 'Filtrar publicaciones en tiempo real',
            hintStyle: TextStyle(
              color: theme.textTheme.bodySmall?.color,
              fontSize: 14,
            ),
            prefixIcon: const Icon(Icons.search, size: 20),
            suffixIcon: controller.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.close, size: 18),
                    onPressed: () {
                      controller.clear();
                      onChanged('');
                    },
                  )
                : null,
            border: InputBorder.none,
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 12),
          ),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant PersistentSearchBarDelegate oldDelegate) {
    return oldDelegate.controller.text != controller.text;
  }
}
