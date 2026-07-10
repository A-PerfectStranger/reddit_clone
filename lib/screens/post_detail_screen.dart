import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../core/utils/time_ago.dart';
import '../models/comment.dart';
import '../models/post.dart';
import '../services/fake_data_service.dart';
import '../widgets/post_card.dart';

/// Pantalla de detalle de una publicación: muestra el post completo y
/// sus comentarios simulados. Usa Hero para animar el avatar/imagen
/// desde la tarjeta del feed.
class PostDetailScreen extends StatelessWidget {
  final Post post;

  const PostDetailScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final comments = FakeDataService.instance.commentsForPost(post);

    return Scaffold(
      appBar: AppBar(title: Text(post.subredditName)),
      body: ListView(
        children: [
          PostCard(post: post),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text('Comentarios', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ),
          const Divider(height: 1),
          ...comments.map((c) => _CommentTile(comment: c)),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _CommentTile extends StatelessWidget {
  final Comment comment;

  const _CommentTile({required this.comment});

  @override
  Widget build(BuildContext context) {
    final color = AppColors.colorFromSeed(comment.authorAvatarColorSeed);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(radius: 14, backgroundColor: color, child: const Icon(Icons.person, size: 14, color: Colors.white)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'u/${comment.authorUsername}  •  ${timeAgo(comment.createdAt)}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 4),
                Text(comment.text),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.arrow_upward, size: 14, color: AppColors.textSecondaryLight),
                    const SizedBox(width: 4),
                    Text('${comment.upvotes}', style: Theme.of(context).textTheme.bodySmall),
                    const SizedBox(width: 12),
                    const Icon(Icons.arrow_downward, size: 14, color: AppColors.textSecondaryLight),
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
