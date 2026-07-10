/// Modelo que representa un usuario dentro de la aplicación.
///
/// Es un modelo simulado: no proviene de ninguna API real, solo se usa
/// para poblar la UI con datos coherentes (autor de un post, comentario,
/// notificación, etc.).
class AppUser {
  final String id;
  final String username;
  final int avatarColorSeed;
  final int karma;
  final DateTime joinDate;

  const AppUser({
    required this.id,
    required this.username,
    required this.avatarColorSeed,
    required this.karma,
    required this.joinDate,
  });
}
