/// Convierte una [DateTime] en un texto corto de "tiempo transcurrido",
/// replicando el formato compacto que utiliza Reddit (ej. "5h", "3d", "2sem").
String timeAgo(DateTime date) {
  final Duration diff = DateTime.now().difference(date);

  if (diff.inSeconds < 60) {
    return 'ahora';
  } else if (diff.inMinutes < 60) {
    return '${diff.inMinutes}m';
  } else if (diff.inHours < 24) {
    return '${diff.inHours}h';
  } else if (diff.inDays < 7) {
    return '${diff.inDays}d';
  } else if (diff.inDays < 30) {
    return '${(diff.inDays / 7).floor()}sem';
  } else if (diff.inDays < 365) {
    return '${(diff.inDays / 30).floor()}mes';
  } else {
    return '${(diff.inDays / 365).floor()}a';
  }
}

/// Formatea números grandes al estilo "1.2k", "3.4M" usados por Reddit
/// en contadores de miembros, votos y comentarios.
String formatCompactNumber(int value) {
  if (value >= 1000000) {
    return '${(value / 1000000).toStringAsFixed(1)}M';
  } else if (value >= 1000) {
    return '${(value / 1000).toStringAsFixed(1)}k';
  }
  return value.toString();
}
