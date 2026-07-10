import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../core/utils/time_ago.dart';
import '../models/post.dart';
import '../services/fake_data_service.dart';

/// Tarjeta que renderiza un post completo dentro del feed.
///
/// Es un [StatefulWidget] porque necesita reaccionar de forma inmediata
/// (optimistic UI) a los taps de voto/guardado sin esperar a que el
/// widget padre reconstruya toda la lista, lo que además mejora la
/// performance al evitar rebuilds innecesarios de [ListView.builder].
class PostCard extends StatefulWidget {
  final Post post;
  final VoidCallback? onCommentTap;

  const PostCard({super.key, required this.post, this.onCommentTap});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard>
    with SingleTickerProviderStateMixin {
  final _service = FakeDataService.instance;
  late final AnimationController _fadeController;

  @override
  void initState() {
    super.initState();
    // Animación de entrada suave (Fade In) al construirse la tarjeta.
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    )..forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  void _handleUpvote() {
    setState(() => _service.toggleUpvote(widget.post));
  }

  void _handleDownvote() {
    setState(() => _service.toggleDownvote(widget.post));
  }

  void _handleSave() {
    setState(() => _service.toggleSave(widget.post));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(widget.post.isSaved
            ? 'Publicación guardada'
            : 'Publicación eliminada de guardados'),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _handleShare() {
    setState(() => widget.post.shareCount += 1);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Enlace copiado al portapapeles'),
        duration: Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final post = widget.post;
    final avatarColor = AppColors.colorFromSeed(post.authorAvatarColorSeed);

    return FadeTransition(
      opacity: _fadeController,
      child: Card(
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: widget.onCommentTap,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(post, avatarColor),
                const SizedBox(height: 8),
                Text(
                  post.title,
                  style: Theme.of(context).textTheme.titleMedium,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                if (post.body != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    post.body!,
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
                if (post.hasImage) ...[
                  const SizedBox(height: 10),
                  _buildImagePlaceholder(post),
                ],
                const SizedBox(height: 8),
                _buildActionsRow(post),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(Post post, Color avatarColor) {
    return Row(
      children: [
        Hero(
          tag: 'avatar_${post.id}',
          child: CircleAvatar(
            radius: 14,
            backgroundColor: avatarColor,
            child: Text(
              post.subredditName.replaceFirst('r/', '')[0].toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: RichText(
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              style: Theme.of(context).textTheme.bodySmall,
              children: [
                TextSpan(
                  text: post.subredditName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimaryLight,
                  ),
                ),
                TextSpan(
                    text:
                        '  •  u/${post.authorUsername}  •  ${timeAgo(post.createdAt)}'),
              ],
            ),
          ),
        ),
        const Icon(Icons.more_vert,
            size: 18, color: AppColors.textSecondaryLight),
      ],
    );
  }

  Widget _buildImagePlaceholder(Post post) {
    // No se cargan imágenes reales (proyecto 100% offline): se simula el
    // espacio con un contenedor de color determinista + ícono, animado con
    // AnimatedContainer para dar sensación de "carga suave".
    final color = AppColors.colorFromSeed(post.imageColorSeed);
    return Hero(
      tag: 'image_${post.id}',
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 160,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            colors: [
              color.withOpacityCompat(0.85),
              color.withOpacityCompat(0.45)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: const Center(
          child: Icon(Icons.image_outlined, color: Colors.white, size: 40),
        ),
      ),
    );
  }

  Widget _buildActionsRow(Post post) {
    return Row(
      children: [
        _VotePill(
          score: post.voteScore,
          isUpvoted: post.isUpvoted,
          isDownvoted: post.isDownvoted,
          onUpvote: _handleUpvote,
          onDownvote: _handleDownvote,
        ),
        const SizedBox(width: 6),
        _ActionButton(
          icon: Icons.mode_comment_outlined,
          label: formatCompactNumber(post.commentCount),
          onTap: widget.onCommentTap,
        ),
        const SizedBox(width: 6),
        _ActionButton(
          icon: Icons.share_outlined,
          label: formatCompactNumber(post.shareCount),
          onTap: _handleShare,
        ),
        const Spacer(),
        _ActionButton(
          icon: post.isSaved ? Icons.bookmark : Icons.bookmark_border,
          label: '',
          iconColor: post.isSaved ? AppColors.redditOrange : null,
          onTap: _handleSave,
        ),
      ],
    );
  }
}

/// Píldora de votos (upvote / score / downvote) con animación de color
/// al cambiar de estado.
class _VotePill extends StatelessWidget {
  final int score;
  final bool isUpvoted;
  final bool isDownvoted;
  final VoidCallback onUpvote;
  final VoidCallback onDownvote;

  const _VotePill({
    required this.score,
    required this.isUpvoted,
    required this.isDownvoted,
    required this.onUpvote,
    required this.onDownvote,
  });

  @override
  Widget build(BuildContext context) {
    final Color scoreColor = isUpvoted
        ? AppColors.upvoteOrange
        : isDownvoted
            ? AppColors.downvoteBlue
            : AppColors.textSecondaryLight;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            visualDensity: VisualDensity.compact,
            icon: Icon(
              Icons.arrow_upward,
              size: 18,
              color: isUpvoted
                  ? AppColors.upvoteOrange
                  : AppColors.textSecondaryLight,
            ),
            onPressed: onUpvote,
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: Text(
              formatCompactNumber(score),
              key: ValueKey(score),
              style: TextStyle(
                color: scoreColor,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
          IconButton(
            visualDensity: VisualDensity.compact,
            icon: Icon(
              Icons.arrow_downward,
              size: 18,
              color: isDownvoted
                  ? AppColors.downvoteBlue
                  : AppColors.textSecondaryLight,
            ),
            onPressed: onDownvote,
          ),
        ],
      ),
    );
  }
}

/// Botón de acción reutilizable (comentar, compartir, guardar) con
/// feedback táctil mediante [InkWell].
class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? iconColor;
  final VoidCallback? onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    this.iconColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon,
                size: 18, color: iconColor ?? AppColors.textSecondaryLight),
            if (label.isNotEmpty) ...[
              const SizedBox(width: 4),
              Text(
                label,
                style: const TextStyle(
                  color: AppColors.textSecondaryLight,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
