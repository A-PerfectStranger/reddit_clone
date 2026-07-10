/// Tipos de notificación soportados, cada uno con su propio ícono/color
/// en la UI (ver [NotificationTile]).
enum NotificationType { upvote, comment, mention, follow, award }

/// Modelo que representa una notificación dentro del centro de
/// notificaciones de la aplicación.
class NotificationModel {
  final String id;
  final NotificationType type;
  final int avatarColorSeed;
  final String text;
  final DateTime createdAt;
  bool isRead;

  NotificationModel({
    required this.id,
    required this.type,
    required this.avatarColorSeed,
    required this.text,
    required this.createdAt,
    this.isRead = false,
  });
}
