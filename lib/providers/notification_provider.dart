import 'package:flutter/material.dart';
import '../models/notification_model.dart';
import '../mock/mock_data.dart';

class NotificationProvider extends ChangeNotifier {
  final List<NotificationModel> _notifications = MockData.generateNotifications()
    ..sort((a, b) => b.time.compareTo(a.time));

  List<NotificationModel> get notifications => _notifications;
  int get unreadCount => _notifications.where((n) => !n.read).length;

  void markAllRead() {
    for (final n in _notifications) {
      n.read = true;
    }
    notifyListeners();
  }
}
