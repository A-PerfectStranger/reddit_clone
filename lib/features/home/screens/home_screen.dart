import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import '../../../providers/feed_provider.dart';
import '../../../providers/theme_provider.dart';
import '../widgets/post_card.dart';
import '../widgets/persistent_search_bar.dart';
import '../../../widgets/shimmer_loading.dart';
import '../../../widgets/avatar_placeholder.dart';
import '../../../mock/mock_data.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback onMenuTap;
  const HomeScreen({super.key, required this.onMenuTap});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 400) {
      context.read<FeedProvider>().loadMore();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final feed = context.watch<FeedProvider>();
    final themeProvider = context.watch<ThemeProvider>();

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: feed.refresh,
          child: CustomScrollView(
            scrollCacheExtent: const ScrollCacheExtent.pixels(800),
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                floating: true,
                snap: true,
                automaticallyImplyLeading: false,
                titleSpacing: 8,
                title: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.menu),
                      onPressed: widget.onMenuTap,
                    ),
                    const _RedditLogoTitle(),
                  ],
                ),
                actions: [
                  IconButton(
                    icon: Icon(themeProvider.isDark
                        ? Icons.light_mode_outlined
                        : Icons.dark_mode_outlined),
                    onPressed: themeProvider.toggle,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: AvatarPlaceholder(
                        seed: MockData.currentUser.avatarSeed, radius: 14),
                  ),
                ],
              ),
              // MEJORA: barra de busqueda persistente (pinned) que filtra
              // el feed en tiempo real mientras el usuario hace scroll.
              SliverPersistentHeader(
                pinned: true,
                delegate: PersistentSearchBarDelegate(
                  controller: _searchController,
                  onChanged: (value) => feed.setQuery(value),
                ),
              ),
              if (feed.posts.isEmpty && feed.query.isNotEmpty)
                const SliverFillRemaining(
                  child: Center(child: Text('No se encontraron publicaciones')),
                )
              else
                SliverList.separated(
                  itemCount: feed.posts.length + (feed.hasMore ? 1 : 0),
                  separatorBuilder: (_, __) => const SizedBox.shrink(),
                  itemBuilder: (context, index) {
                    if (index >= feed.posts.length) {
                      return const ShimmerPostCard();
                    }
                    final post = feed.posts[index];
                    return AnimatedFadeIn(
                      key: ValueKey(post.id),
                      child: PostCard(
                        post: post,
                        onUpvote: () => feed.toggleUpvote(post),
                        onDownvote: () => feed.toggleDownvote(post),
                        onSave: () => feed.toggleSave(post),
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RedditLogoTitle extends StatelessWidget {
  const _RedditLogoTitle();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: const BoxDecoration(
            color: Color(0xFFFF4500),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.forum_rounded, color: Colors.white, size: 16),
        ),
        const SizedBox(width: 8),
        Text(
          'reddit',
          style: theme.textTheme.titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

/// Animacion implicita de entrada (fade + slide sutil) para cada item
/// del feed a medida que aparece.
class AnimatedFadeIn extends StatefulWidget {
  final Widget child;
  const AnimatedFadeIn({super.key, required this.child});

  @override
  State<AnimatedFadeIn> createState() => _AnimatedFadeInState();
}

class _AnimatedFadeInState extends State<AnimatedFadeIn> {
  double _opacity = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) setState(() => _opacity = 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _opacity,
      duration: const Duration(milliseconds: 300),
      child: widget.child,
    );
  }
}
