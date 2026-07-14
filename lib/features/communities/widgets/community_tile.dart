import 'package:flutter/material.dart';
import '../../../models/community_model.dart';
import '../../../widgets/avatar_placeholder.dart';
import '../../../core/theme/app_colors.dart';

class CommunityTile extends StatelessWidget {
  final CommunityModel community;
  final VoidCallback onJoin;

  const CommunityTile({super.key, required this.community, required this.onJoin});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      leading: AvatarPlaceholder(seed: community.iconSeed, radius: 20),
      title: Text('r/${community.name}', style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(community.formattedMembers, style: theme.textTheme.bodySmall),
      trailing: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        child: OutlinedButton(
          onPressed: onJoin,
          style: OutlinedButton.styleFrom(
            backgroundColor: community.joined ? Colors.transparent : AppColors.redditOrange,
            foregroundColor: community.joined ? theme.textTheme.bodyMedium?.color : Colors.white,
            side: BorderSide(
              color: community.joined
                  ? theme.dividerTheme.color ?? Colors.grey
                  : AppColors.redditOrange,
            ),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            padding: const EdgeInsets.symmetric(horizontal: 16),
          ),
          child: Text(community.joined ? 'Joined' : 'Join'),
        ),
      ),
    );
  }
}
