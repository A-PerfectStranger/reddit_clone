class CommentModel {
  final String id;
  final String author;
  final String avatarSeed;
  final String text;
  final int votes;
  final DateTime createdAt;
  final int depth;

  const CommentModel({
    required this.id,
    required this.author,
    required this.avatarSeed,
    required this.text,
    required this.votes,
    required this.createdAt,
    this.depth = 0,
  });
}
