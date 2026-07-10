import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../core/utils/time_ago.dart';
import '../models/notification_model.dart';

/// Elemento individual de la lista de notificaciones.
///
/// Muestra un punto azul cuando la notificación no ha sido leída,
/// replicando el patrón visual estándar de indicadores "unread".
class NotificationTile extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback onTap;

  const NotificationTile({
    super.key,
    required this.notification,
    required this.onTap,
  });

  IconData get _icon {
    switch (notification.type) {
      case NotificationType.upvote:
        return Icons.arrow_upward;
      case NotificationType.comment:
        return Icons.mode_comment;
      case NotificationType.mention:
        return Icons.alternate_email;
      case NotificationType.follow:
        return Icons.person_add;
      case NotificationType.award:
        return Icons.emoji_events;
    }
  }

  @override
  Widget build(BuildContext context) {
    final avatarColor = AppColors.colorFromSeed(notification.avatarColorSeed);

    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        color: notification.isRead
            ? Colors.transparent
            : AppColors.redditOrange.withOpacityCompat(0.06),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: avatarColor,
                  child: Icon(_icon, color: Colors.white, size: 18),
                ),
                if (!notification.isRead)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: AppColors.redditBlue,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1.5),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.text,
                    style: TextStyle(
                      fontWeight: notification.isRead
                          ? FontWeight.normal
                          : FontWeight.w600,
                      color: AppColors.textPrimaryLight,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    timeAgo(notification.createdAt),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
