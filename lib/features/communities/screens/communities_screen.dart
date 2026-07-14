import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import '../../../providers/community_provider.dart';
import '../widgets/community_tile.dart';

class CommunitiesScreen extends StatelessWidget {
  const CommunitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CommunityProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('Communities')),
      body: ListView.separated(
        scrollCacheExtent: const ScrollCacheExtent.pixels(600),
        itemCount: provider.communities.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final community = provider.communities[index];
          return CommunityTile(
            key: ValueKey(community.id),
            community: community,
            onJoin: () => provider.toggleJoin(community),
          );
        },
      ),
    );
  }
}
