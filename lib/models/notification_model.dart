import 'package:flutter/material.dart';

enum NotificationType { upvote, comment, mention, follower, community }

class NotificationModel {
  final String id;
  final NotificationType type;
  final String username;
  final String message;
  final DateTime time;
  bool read;

  NotificationModel({
    required this.id,
    required this.type,
    required this.username,
    required this.message,
    required this.time,
    this.read = false,
  });

  IconData get icon {
    switch (type) {
      case NotificationType.upvote:
        return Icons.arrow_upward_rounded;
      case NotificationType.comment:
        return Icons.chat_bubble_outline_rounded;
      case NotificationType.mention:
        return Icons.alternate_email_rounded;
      case NotificationType.follower:
        return Icons.person_add_alt_1_rounded;
      case NotificationType.community:
        return Icons.groups_rounded;
    }
  }

  String get timeAgo {
    final diff = DateTime.now().difference(time);
    if (diff.inDays > 0) return '${diff.inDays}d';
    if (diff.inHours > 0) return '${diff.inHours}h';
    if (diff.inMinutes > 0) return '${diff.inMinutes}m';
    return 'now';
  }
}
