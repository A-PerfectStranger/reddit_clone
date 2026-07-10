/// Modelo que representa un comentario dentro de un post.
class Comment {
  final String id;
  final String postId;
  final String authorUsername;
  final int authorAvatarColorSeed;
  final String text;
  final DateTime createdAt;
  int upvotes;

  Comment({
    required this.id,
    required this.postId,
    required this.authorUsername,
    required this.authorAvatarColorSeed,
    required this.text,
    required this.createdAt,
    this.upvotes = 0,
  });
}
