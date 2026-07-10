import '../data/fake_comments.dart';
import '../data/fake_notifications.dart';
import '../data/fake_posts.dart';
import '../data/fake_subreddits.dart';
import '../data/fake_users.dart';
import '../models/comment.dart';
import '../models/notification_model.dart';
import '../models/post.dart';
import '../models/subreddit.dart';
import '../models/user.dart';

/// Servicio central de datos simulados.
///
/// Cumple el rol de "capa de datos" dentro de la arquitectura, exponiendo
/// una API similar a la que tendría un repositorio real (con delays
/// artificiales para simular latencia de red), pero manteniendo todo en
/// memoria. Se implementa como singleton para que el estado (votos,
/// comunidades unidas, notificaciones leídas) persista mientras la app
/// está abierta.
class FakeDataService {
  FakeDataService._internal() {
    users = generateFakeUsers();
    subreddits = generateFakeSubreddits();
    posts = generateFakePosts(subreddits: subreddits, users: users);
    notifications = generateFakeNotifications();
  }

  static final FakeDataService instance = FakeDataService._internal();

  late final List<AppUser> users;
  late final List<Subreddit> subreddits;
  late final List<Post> posts;
  late final List<NotificationModel> notifications;

  /// Simula una llamada de red para obtener el feed principal.
  Future<List<Post>> fetchFeed({Duration delay = const Duration(milliseconds: 700)}) async {
    await Future.delayed(delay);
    return List.unmodifiable(posts);
  }

  /// Simula la carga de una página adicional de posts (scroll infinito).
  Future<List<Post>> fetchMorePosts({
    required int offset,
    int limit = 15,
    Duration delay = const Duration(milliseconds: 500),
  }) async {
    await Future.delayed(delay);
    if (offset >= posts.length) return [];
    final end = (offset + limit).clamp(0, posts.length);
    return posts.sublist(offset, end);
  }

  Future<List<Subreddit>> fetchCommunities({Duration delay = const Duration(milliseconds: 600)}) async {
    await Future.delayed(delay);
    return List.unmodifiable(subreddits);
  }

  Future<List<NotificationModel>> fetchNotifications({Duration delay = const Duration(milliseconds: 600)}) async {
    await Future.delayed(delay);
    return List.unmodifiable(notifications);
  }

  List<Comment> commentsForPost(Post post) {
    return generateFakeCommentsForPost(post: post, users: users);
  }

  void toggleJoin(Subreddit subreddit) {
    subreddit.isJoined = !subreddit.isJoined;
  }

  void markAllNotificationsRead() {
    for (final n in notifications) {
      n.isRead = true;
    }
  }

  void toggleUpvote(Post post) {
    if (post.isUpvoted) {
      post.isUpvoted = false;
      post.upvotes -= 1;
    } else {
      if (post.isDownvoted) {
        post.isDownvoted = false;
        post.downvotes -= 1;
      }
      post.isUpvoted = true;
      post.upvotes += 1;
    }
  }

  void toggleDownvote(Post post) {
    if (post.isDownvoted) {
      post.isDownvoted = false;
      post.downvotes -= 1;
    } else {
      if (post.isUpvoted) {
        post.isUpvoted = false;
        post.upvotes -= 1;
      }
      post.isDownvoted = true;
      post.downvotes += 1;
    }
  }

  void toggleSave(Post post) {
    post.isSaved = !post.isSaved;
  }

  /// Filtra el feed en tiempo real por título, subreddit o autor.
  /// Utilizado por la mejora de UX (barra de búsqueda persistente).
  List<Post> searchPosts(String query) {
    if (query.trim().isEmpty) return List.unmodifiable(posts);
    final lower = query.toLowerCase();
    return posts.where((p) {
      return p.title.toLowerCase().contains(lower) ||
          p.subredditName.toLowerCase().contains(lower) ||
          p.authorUsername.toLowerCase().contains(lower);
    }).toList();
  }
}
