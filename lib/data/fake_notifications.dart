import 'dart:math';
import '../models/notification_model.dart';

/// Genera 80 notificaciones simuladas cubriendo los distintos tipos
/// soportados por la app (upvotes, comentarios, menciones, seguidores,
/// premios).
List<NotificationModel> generateFakeNotifications({
  int count = 80,
  int seed = 17,
}) {
  final random = Random(seed);

  const textsByType = {
    NotificationType.upvote: [
      'tu publicación en r/flutterdev alcanzó 1.2k upvotes',
      'a 45 personas les gustó tu comentario',
      'tu post está en tendencia dentro de la comunidad',
    ],
    NotificationType.comment: [
      'comentó en tu publicación: "Muy buen aporte..."',
      'respondió a tu comentario',
      'dejó una respuesta en el hilo que sigues',
    ],
    NotificationType.mention: [
      'te mencionó en r/programming',
      'te etiquetó en un comentario',
      'te mencionó en una discusión activa',
    ],
    NotificationType.follow: [
      'comenzó a seguirte',
      'se unió a una comunidad que administras',
      'ahora es parte de tus seguidores',
    ],
    NotificationType.award: [
      'te otorgó un premio Gold',
      'reconoció tu publicación con un premio',
      'te envió un premio Silver por tu aporte',
    ],
  };

  const usersForNotifications = [
    'pixel_queen',
    'nova_byte',
    'quiet_storm',
    'moss_hunter',
    'lunar_fox',
    'ctrl_alt_dev',
    'sunday_coder',
    'echo_wanderer',
    'blue_kestrel',
    'rusty_anchor',
  ];

  final types = NotificationType.values;

  return List.generate(count, (index) {
    final type = types[random.nextInt(types.length)];
    final options = textsByType[type]!;
    final user =
        usersForNotifications[random.nextInt(usersForNotifications.length)];
    final text = 'u/$user ${options[random.nextInt(options.length)]}';

    return NotificationModel(
      id: 'notif_$index',
      type: type,
      avatarColorSeed: random.nextInt(12),
      text: text,
      createdAt: DateTime.now().subtract(
        Duration(minutes: random.nextInt(60 * 24 * 20)),
      ),
      isRead: random.nextDouble() < 0.55,
    );
  });
}
