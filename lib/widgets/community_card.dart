import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../core/utils/time_ago.dart';
import '../models/subreddit.dart';

/// Tarjeta que representa una comunidad dentro de la lista de
/// Comunidades. Incluye un botón "Join/Joined" con animación de color.
class CommunityCard extends StatefulWidget {
  final Subreddit subreddit;
  final VoidCallback onJoinToggle;

  const CommunityCard({
    super.key,
    required this.subreddit,
    required this.onJoinToggle,
  });

  @override
  State<CommunityCard> createState() => _CommunityCardState();
}

class _CommunityCardState extends State<CommunityCard> {
  @override
  Widget build(BuildContext context) {
    final subreddit = widget.subreddit;
    final iconColor = AppColors.colorFromSeed(subreddit.iconColorSeed);

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: iconColor,
                child: Text(
                  subreddit.name.replaceFirst('r/', '')[0].toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subreddit.name,
                      style: Theme.of(context).textTheme.titleMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${formatCompactNumber(subreddit.memberCount)} miembros',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subreddit.description,
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              _JoinButton(
                isJoined: subreddit.isJoined,
                onTap: widget.onJoinToggle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _JoinButton extends StatelessWidget {
  final bool isJoined;
  final VoidCallback onTap;

  const _JoinButton({required this.isJoined, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: isJoined ? Colors.transparent : AppColors.redditOrange,
        border: Border.all(
          color: AppColors.redditOrange,
          width: 1.4,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              isJoined ? 'Joined' : 'Join',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: isJoined ? AppColors.redditOrange : Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
