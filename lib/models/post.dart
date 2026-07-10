/// Modelo que representa una publicación (post) dentro de un feed.
///
/// Los campos de interacción (upvotes, downvotes, isSaved, etc.) son
/// mutables porque el usuario puede modificarlos localmente al interactuar
/// con la tarjeta del post (ver [PostCard]).
class Post {
  final String id;
  final String subredditId;
  final String subredditName;
  final String authorUsername;
  final int authorAvatarColorSeed;
  final DateTime createdAt;
  final String title;
  final String? body;
  final bool hasImage;
  final int imageColorSeed;
  int upvotes;
  int downvotes;
  int commentCount;
  int shareCount;
  bool isUpvoted;
  bool isDownvoted;
  bool isSaved;

  Post({
    required this.id,
    required this.subredditId,
    required this.subredditName,
    required this.authorUsername,
    required this.authorAvatarColorSeed,
    required this.createdAt,
    required this.title,
    this.body,
    this.hasImage = false,
    this.imageColorSeed = 0,
    this.upvotes = 0,
    this.downvotes = 0,
    this.commentCount = 0,
    this.shareCount = 0,
    this.isUpvoted = false,
    this.isDownvoted = false,
    this.isSaved = false,
  });

  /// Saldo neto de votos (lo que Reddit muestra como "puntuación").
  int get voteScore => upvotes - downvotes;
}
