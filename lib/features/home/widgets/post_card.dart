import 'package:flutter/material.dart';
import '../../../models/post_model.dart';
import '../../../widgets/avatar_placeholder.dart';
import '../../../widgets/image_placeholder.dart';
import '../../../core/theme/app_colors.dart';
import '../../post/screens/post_detail_screen.dart';

/// Tarjeta de publicacion del feed. const donde es posible, y
/// AutomaticKeepAliveClientMixin evitado a proposito (el feed usa
/// ListView.builder estandar, mas liviano para listas largas).
class PostCard extends StatelessWidget {
  final PostModel post;
  final VoidCallback onUpvote;
  final VoidCallback onDownvote;
  final VoidCallback onSave;

  const PostCard({
    super.key,
    required this.post,
    required this.onUpvote,
    required this.onDownvote,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PostDetailScreen(post: post),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: theme.dividerTheme.color!, width: 8),
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Hero(
                    tag: 'avatar_${post.id}',
                    child: AvatarPlaceholder(seed: post.communityIconSeed, radius: 14),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: RichText(
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.textTheme.bodySmall?.color,
                        ),
                        children: [
                          TextSpan(
                            text: 'r/${post.community}  ',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: 'u/${post.author} · ${post.timeAgo}'),
                        ],
                      ),
                    ),
                  ),
                  const Icon(Icons.more_vert, size: 18),
                ],
              ),
            ),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                post.title,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (post.bodyText != null) ...[
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  post.bodyText!,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium,
                ),
              ),
            ],
            if (post.imageSeed != null) ...[
              const SizedBox(height: 8),
              Hero(
                tag: 'image_${post.id}',
                child: ImagePlaceholder(seed: post.imageSeed!),
              ),
            ],
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  _VotePill(post: post, onUpvote: onUpvote, onDownvote: onDownvote),
                  const SizedBox(width: 8),
                  _ActionChip(
                    icon: Icons.chat_bubble_outline_rounded,
                    label: post.formattedComments,
                  ),
                  const Spacer(),
                  _IconAction(
                    icon: Icons.share_outlined,
                    onTap: () {},
                  ),
                  const SizedBox(width: 4),
                  _IconAction(
                    icon: post.saved ? Icons.bookmark : Icons.bookmark_border,
                    color: post.saved ? AppColors.redditOrange : null,
                    onTap: onSave,
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

class _VotePill extends StatelessWidget {
  final PostModel post;
  final VoidCallback onUpvote;
  final VoidCallback onDownvote;

  const _VotePill({
    required this.post,
    required this.onUpvote,
    required this.onDownvote,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.dark
            ? const Color(0xFF272729)
            : const Color(0xFFF6F7F8),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ScaleIconButton(
            icon: Icons.arrow_upward_rounded,
            color: post.voteState == 1 ? AppColors.upvote : null,
            onTap: onUpvote,
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: Text(
              post.formattedVotes,
              key: ValueKey(post.upvotes),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: post.voteState == 1
                    ? AppColors.upvote
                    : post.voteState == -1
                        ? AppColors.downvote
                        : theme.textTheme.bodyMedium?.color,
              ),
            ),
          ),
          _ScaleIconButton(
            icon: Icons.arrow_downward_rounded,
            color: post.voteState == -1 ? AppColors.downvote : null,
            onTap: onDownvote,
          ),
        ],
      ),
    );
  }
}

class _ActionChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ActionChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.dark
            ? const Color(0xFF272729)
            : const Color(0xFFF6F7F8),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _IconAction extends StatelessWidget {
  final IconData icon;
  final Color? color;
  final VoidCallback onTap;

  const _IconAction({required this.icon, required this.onTap, this.color});

  @override
  Widget build(BuildContext context) {
    return _ScaleIconButton(icon: icon, color: color, onTap: onTap, filled: true);
  }
}

/// Boton reutilizable con micro-animacion de "scale" al presionar.
class _ScaleIconButton extends StatefulWidget {
  final IconData icon;
  final Color? color;
  final VoidCallback onTap;
  final bool filled;

  const _ScaleIconButton({
    required this.icon,
    required this.onTap,
    this.color,
    this.filled = false,
  });

  @override
  State<_ScaleIconButton> createState() => _ScaleIconButtonState();
}

class _ScaleIconButtonState extends State<_ScaleIconButton> {
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTapDown: (_) => setState(() => _scale = 0.85),
      onTapUp: (_) => setState(() => _scale = 1.0),
      onTapCancel: () => setState(() => _scale = 1.0),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 100),
        child: Container(
          padding: EdgeInsets.all(widget.filled ? 8 : 6),
          decoration: widget.filled
              ? BoxDecoration(
                  color: theme.brightness == Brightness.dark
                      ? const Color(0xFF272729)
                      : const Color(0xFFF6F7F8),
                  shape: BoxShape.circle,
                )
              : null,
          child: Icon(widget.icon, size: 18, color: widget.color),
        ),
      ),
    );
  }
}
