class ChatModel {
  final String id;
  final String name;
  final String avatarSeed;
  final String lastMessage;
  final DateTime time;
  final int unreadCount;

  const ChatModel({
    required this.id,
    required this.name,
    required this.avatarSeed,
    required this.lastMessage,
    required this.time,
    this.unreadCount = 0,
  });

  String get timeAgo {
    final diff = DateTime.now().difference(time);
    if (diff.inDays > 0) return '${diff.inDays}d';
    if (diff.inHours > 0) return '${diff.inHours}h';
    if (diff.inMinutes > 0) return '${diff.inMinutes}m';
    return 'now';
  }
}
