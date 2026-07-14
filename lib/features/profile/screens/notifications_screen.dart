import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import '../../../providers/notification_provider.dart';
import '../../../models/notification_model.dart';
import '../../../core/theme/app_colors.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<NotificationProvider>();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Activity'),
          bottom: const TabBar(
            tabs: [Tab(text: 'Notifications'), Tab(text: 'Chats')],
          ),
          actions: [
            TextButton(
              onPressed: provider.markAllRead,
              child: const Text('Mark all read'),
            ),
          ],
        ),
        body: TabBarView(
          children: [
            ListView.separated(
              scrollCacheExtent: const ScrollCacheExtent.pixels(600),
              itemCount: provider.notifications.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final n = provider.notifications[index];
                return _NotificationTile(notification: n);
              },
            ),
            const Center(
                child: Text('Ir a la pestana Chat para ver tus mensajes')),
          ],
        ),
      ),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  final NotificationModel notification;
  const _NotificationTile({required this.notification});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: notification.read
          ? null
          : theme.colorScheme.primary.withValues(alpha: 0.06),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.redditOrange.withValues(alpha: 0.15),
          child:
              Icon(notification.icon, color: AppColors.redditOrange, size: 20),
        ),
        title: Text(notification.username,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(notification.message,
            maxLines: 2, overflow: TextOverflow.ellipsis),
        trailing: Text(notification.timeAgo, style: theme.textTheme.bodySmall),
      ),
    );
  }
}
