import 'package:flutter/material.dart';
import '../../../models/post_model.dart';
import '../../../widgets/avatar_placeholder.dart';
import '../../../widgets/image_placeholder.dart';
import '../../../core/theme/app_colors.dart';
import '../widgets/comment_tile.dart';

class PostDetailScreen extends StatefulWidget {
  final PostModel post;
  const PostDetailScreen({super.key, required this.post});

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  final TextEditingController _replyController = TextEditingController();

  void _upvote() {
    setState(() {
      final p = widget.post;
      if (p.voteState == 1) {
        p.upvotes -= 1;
        p.voteState = 0;
      } else {
        p.upvotes += (p.voteState == -1) ? 2 : 1;
        p.voteState = 1;
      }
    });
  }

  void _downvote() {
    setState(() {
      final p = widget.post;
      if (p.voteState == -1) {
        p.upvotes += 1;
        p.voteState = 0;
      } else {
        p.upvotes -= (p.voteState == 1) ? 2 : 1;
        p.voteState = -1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final post = widget.post;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('r/${post.community}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Row(
                    children: [
                      Hero(
                        tag: 'avatar_${post.id}',
                        child: AvatarPlaceholder(seed: post.communityIconSeed, radius: 14),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'r/${post.community} · u/${post.author} · ${post.timeAgo}',
                          style: theme.textTheme.bodySmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(post.title, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                ),
                if (post.bodyText != null)
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(post.bodyText!, style: theme.textTheme.bodyMedium),
                  ),
                if (post.imageSeed != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Hero(
                      tag: 'image_${post.id}',
                      child: ImagePlaceholder(seed: post.imageSeed!, height: 280),
                    ),
                  ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      _VoteRow(post: post, onUpvote: _upvote, onDownvote: _downvote),
                      const Spacer(),
                      const Icon(Icons.share_outlined, size: 20),
                    ],
                  ),
                ),
                const Divider(height: 24, thickness: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text('Comentarios (${post.comments.length})',
                      style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 4),
                ...post.comments.map((c) => CommentTile(comment: c)),
                const SizedBox(height: 80),
              ],
            ),
          ),
          SafeArea(
            top: false,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: theme.dividerTheme.color!)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _replyController,
                      decoration: InputDecoration(
                        hintText: 'Add a comment',
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send_rounded, color: AppColors.redditOrange),
                    onPressed: () {
                      if (_replyController.text.trim().isEmpty) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Comentario simulado enviado')),
                      );
                      _replyController.clear();
                      FocusScope.of(context).unfocus();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _VoteRow extends StatelessWidget {
  final PostModel post;
  final VoidCallback onUpvote;
  final VoidCallback onDownvote;

  const _VoteRow({required this.post, required this.onUpvote, required this.onDownvote});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.arrow_upward_rounded,
              color: post.voteState == 1 ? AppColors.upvote : null),
          onPressed: onUpvote,
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: Text(
            post.formattedVotes,
            key: ValueKey(post.upvotes),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: post.voteState == 1
                  ? AppColors.upvote
                  : post.voteState == -1
                      ? AppColors.downvote
                      : null,
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.arrow_downward_rounded,
              color: post.voteState == -1 ? AppColors.downvote : null),
          onPressed: onDownvote,
        ),
      ],
    );
  }
}
