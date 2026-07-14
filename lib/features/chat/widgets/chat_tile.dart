import 'package:flutter/material.dart';
import '../../../models/chat_model.dart';
import '../../../widgets/avatar_placeholder.dart';
import '../../../core/theme/app_colors.dart';

class ChatTile extends StatelessWidget {
  final ChatModel chat;

  const ChatTile({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final unread = chat.unreadCount > 0;
    return ListTile(
      leading: AvatarPlaceholder(seed: chat.avatarSeed, radius: 22),
      title: Text(
        'u/${chat.name}',
        style: TextStyle(fontWeight: unread ? FontWeight.bold : FontWeight.normal),
      ),
      subtitle: Text(
        chat.lastMessage,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: theme.textTheme.bodySmall?.copyWith(
          fontWeight: unread ? FontWeight.w600 : FontWeight.normal,
          color: unread ? theme.textTheme.bodyMedium?.color : theme.textTheme.bodySmall?.color,
        ),
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(chat.timeAgo, style: theme.textTheme.bodySmall),
          const SizedBox(height: 6),
          if (unread)
            Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                color: AppColors.unreadDot,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Abrir chat con u/${chat.name} (simulado)')),
        );
      },
    );
  }
}
