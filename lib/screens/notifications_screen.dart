import 'package:flutter/material.dart';
import '../models/notification_model.dart';
import '../services/fake_data_service.dart';
import '../widgets/loading_skeleton.dart';
import '../widgets/notification_tile.dart';

/// Pantalla de Notificaciones: lista vertical con indicador de "no leído"
/// y opción de marcar todas como leídas.
class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final _service = FakeDataService.instance;
  List<NotificationModel> _notifications = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final data = await _service.fetchNotifications();
    setState(() {
      _notifications = data;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificaciones'),
        actions: [
          TextButton(
            onPressed: () {
              setState(() => _service.markAllNotificationsRead());
            },
            child: const Text('Marcar leídas'),
          ),
        ],
      ),
      body: _isLoading
          ? ListView.builder(
              itemCount: 6,
              itemBuilder: (context, index) => const PostCardSkeleton(),
            )
          : RefreshIndicator(
              onRefresh: _load,
              child: ListView.separated(
                itemCount: _notifications.length,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final notification = _notifications[index];
                  return NotificationTile(
                    key: ValueKey(notification.id),
                    notification: notification,
                    onTap: () {
                      setState(() => notification.isRead = true);
                    },
                  );
                },
              ),
            ),
    );
  }
}
