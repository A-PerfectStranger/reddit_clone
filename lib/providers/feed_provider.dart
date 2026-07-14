import 'package:flutter/material.dart';
import '../models/post_model.dart';
import '../mock/mock_data.dart';

/// Controla el feed principal: carga inicial, scroll infinito (paginado
/// sobre datos simulados), pull-to-refresh, y el filtro de busqueda
/// en tiempo real (la mejora propuesta del taller).
class FeedProvider extends ChangeNotifier {
  final List<PostModel> _allPosts = MockData.generatePosts();
  final List<PostModel> _visiblePosts = [];

  static const int _pageSize = 10;
  int _loadedCount = 0;
  bool _isLoadingMore = false;
  bool _isRefreshing = false;
  String _query = '';

  List<PostModel> get posts {
    if (_query.trim().isEmpty) return _visiblePosts;
    final q = _query.toLowerCase();
    return _visiblePosts
        .where((p) =>
            p.title.toLowerCase().contains(q) ||
            p.community.toLowerCase().contains(q) ||
            p.author.toLowerCase().contains(q))
        .toList();
  }

  bool get isLoadingMore => _isLoadingMore;
  bool get isRefreshing => _isRefreshing;
  bool get hasMore => _loadedCount < _allPosts.length;
  String get query => _query;

  FeedProvider() {
    _loadMore();
  }

  void setQuery(String value) {
    _query = value;
    notifyListeners();
  }

  Future<void> _loadMore() async {
    if (_isLoadingMore || !hasMore) return;
    _isLoadingMore = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 500));
    final next = (_loadedCount + _pageSize).clamp(0, _allPosts.length);
    _visiblePosts.addAll(_allPosts.sublist(_loadedCount, next));
    _loadedCount = next;
    _isLoadingMore = false;
    notifyListeners();
  }

  Future<void> loadMore() => _loadMore();

  Future<void> refresh() async {
    _isRefreshing = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 800));
    _visiblePosts.clear();
    _loadedCount = 0;
    _isRefreshing = false;
    await _loadMore();
  }

  void toggleUpvote(PostModel post) {
    if (post.voteState == 1) {
      post.upvotes -= 1;
      post.voteState = 0;
    } else {
      post.upvotes += (post.voteState == -1) ? 2 : 1;
      post.voteState = 1;
    }
    notifyListeners();
  }

  void toggleDownvote(PostModel post) {
    if (post.voteState == -1) {
      post.upvotes += 1;
      post.voteState = 0;
    } else {
      post.upvotes -= (post.voteState == 1) ? 2 : 1;
      post.voteState = -1;
    }
    notifyListeners();
  }

  void toggleSave(PostModel post) {
    post.saved = !post.saved;
    notifyListeners();
  }
}
