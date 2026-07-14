import 'package:flutter/material.dart';
import '../../../models/comment_model.dart';
import '../../../widgets/avatar_placeholder.dart';

class CommentTile extends StatelessWidget {
  final CommentModel comment;

  const CommentTile({super.key, required this.comment});

  String get _timeAgo {
    final diff = DateTime.now().difference(comment.createdAt);
    if (diff.inDays > 0) return '${diff.inDays}d';
    if (diff.inHours > 0) return '${diff.inHours}h';
    return '${diff.inMinutes}m';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(left: comment.depth * 20.0, top: 10, bottom: 10, right: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AvatarPlaceholder(seed: comment.avatarSeed, radius: 12),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: theme.textTheme.bodySmall,
                    children: [
                      TextSpan(
                        text: 'u/${comment.author}  ',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: '· $_timeAgo'),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Text(comment.text, style: theme.textTheme.bodyMedium),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.arrow_upward_rounded, size: 14),
                    const SizedBox(width: 4),
                    Text('${comment.votes}', style: const TextStyle(fontSize: 12)),
                    const SizedBox(width: 10),
                    const Icon(Icons.arrow_downward_rounded, size: 14),
                    const SizedBox(width: 16),
                    Text('Reply', style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
