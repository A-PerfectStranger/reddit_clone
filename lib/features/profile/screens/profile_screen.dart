import 'package:flutter/material.dart';
import '../../../mock/mock_data.dart';
import '../../../providers/feed_provider.dart';
import 'package:provider/provider.dart';
import '../../../widgets/avatar_placeholder.dart';
import '../../home/widgets/post_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = MockData.currentUser;
    final feed = context.watch<FeedProvider>();
    final savedPosts = feed.posts.where((p) => p.saved).toList();

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              expandedHeight: 220,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF0079D3), Color(0xFF030303)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  padding: const EdgeInsets.fromLTRB(16, 60, 16, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      AvatarPlaceholder(seed: user.avatarSeed, radius: 36),
                      const SizedBox(height: 8),
                      Text(user.username,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                      Text('u/${user.username}',
                          style: const TextStyle(color: Colors.white70, fontSize: 13)),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _StatColumn(label: 'Karma', value: '${user.karma}'),
                    _StatColumn(label: 'Posts guardados', value: '${savedPosts.length}'),
                    const _StatColumn(label: 'Account age', value: '1m'),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: TabBar(
                tabs: [Tab(text: 'Posts'), Tab(text: 'Saved'), Tab(text: 'About')],
              ),
            ),
          ],
          body: TabBarView(
            children: [
              const Center(child: Text('You don\'t have any posts yet')),
              savedPosts.isEmpty
                  ? const Center(child: Text('No has guardado publicaciones'))
                  : ListView.builder(
                      itemCount: savedPosts.length,
                      itemBuilder: (context, index) {
                        final post = savedPosts[index];
                        return PostCard(
                          post: post,
                          onUpvote: () => feed.toggleUpvote(post),
                          onDownvote: () => feed.toggleDownvote(post),
                          onSave: () => feed.toggleSave(post),
                        );
                      },
                    ),
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                    'Cuenta simulada creada para el taller de Desarrollo de Aplicaciones Moviles. Todos los datos son ficticios.'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatColumn extends StatelessWidget {
  final String label;
  final String value;
  const _StatColumn({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
