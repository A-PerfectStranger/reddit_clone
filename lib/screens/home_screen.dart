import 'package:flutter/material.dart';
import '../models/post.dart';
import '../services/fake_data_service.dart';
import '../widgets/loading_skeleton.dart';
import '../widgets/persistent_search_bar.dart';
import '../widgets/post_card.dart';
import '../widgets/app_drawer.dart';
import 'post_detail_screen.dart';

/// Pantalla principal: Feed infinito de publicaciones.
///
/// Implementa:
///  - Carga inicial con skeleton loaders.
///  - Scroll infinito (paginación) usando [ListView.builder].
///  - Pull to refresh.
///  - Barra de búsqueda persistente (mejora de UX) que filtra en vivo.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _service = FakeDataService.instance;
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();

  final List<Post> _loadedPosts = [];
  List<Post> _filteredPosts = [];
  bool _isLoading = true;
  bool _isLoadingMore = false;
  bool _isSearching = false;
  int _offset = 0;
  static const int _pageSize = 15;

  @override
  void initState() {
    super.initState();
    _loadInitial();
    _scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadInitial() async {
    setState(() => _isLoading = true);
    final firstPage = await _service.fetchMorePosts(offset: 0, limit: _pageSize);
    setState(() {
      _loadedPosts
        ..clear()
        ..addAll(firstPage);
      _offset = firstPage.length;
      _filteredPosts = List.of(_loadedPosts);
      _isLoading = false;
    });
  }

  Future<void> _handleRefresh() async {
    _offset = 0;
    await _loadInitial();
  }

  void _handleScroll() {
    if (_isSearching) return; // No paginar mientras se filtra localmente.
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 300) {
      _loadMore();
    }
  }

  Future<void> _loadMore() async {
    if (_isLoadingMore) return;
    setState(() => _isLoadingMore = true);
    final nextPage = await _service.fetchMorePosts(offset: _offset, limit: _pageSize);
    setState(() {
      _loadedPosts.addAll(nextPage);
      _offset += nextPage.length;
      _filteredPosts = List.of(_loadedPosts);
      _isLoadingMore = false;
    });
  }

  void _handleSearchChanged(String query) {
    setState(() {
      _isSearching = query.trim().isNotEmpty;
      // Al buscar, se filtra sobre todo el dataset disponible (no solo la
      // página cargada), dando resultados completos en tiempo real.
      _filteredPosts = _isSearching ? _service.searchPosts(query) : List.of(_loadedPosts);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.circle, color: Theme.of(context).colorScheme.primary, size: 28),
            const SizedBox(width: 8),
            const Text('reddit', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            tooltip: 'Crear publicación',
            onPressed: () {},
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: PersistentSearchBarDelegate(
                controller: _searchController,
                onChanged: _handleSearchChanged,
              ),
            ),
            if (_isLoading)
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => const PostCardSkeleton(),
                  childCount: 5,
                ),
              )
            else if (_filteredPosts.isEmpty)
              const SliverFillRemaining(
                child: Center(child: Text('No se encontraron publicaciones')),
              )
            else
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (index == _filteredPosts.length) {
                      return _isLoadingMore && !_isSearching
                          ? const Padding(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              child: Center(child: CircularProgressIndicator()),
                            )
                          : const SizedBox.shrink();
                    }
                    final post = _filteredPosts[index];
                    return PostCard(
                      key: ValueKey(post.id),
                      post: post,
                      onCommentTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => PostDetailScreen(post: post),
                          ),
                        );
                      },
                    );
                  },
                  childCount: _filteredPosts.length + 1,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
