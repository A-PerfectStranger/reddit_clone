import 'comment_model.dart';

class PostModel {
  final String id;
  final String author;
  final String avatarSeed;
  final String community;
  final String communityIconSeed;
  final DateTime createdAt;
  final String title;
  final String? bodyText;
  final String? imageSeed;
  int upvotes;
  final int commentCount;
  bool saved;
  bool joined;
  int voteState; // -1, 0, 1
  final List<CommentModel> comments;

  PostModel({
    required this.id,
    required this.author,
    required this.avatarSeed,
    required this.community,
    required this.communityIconSeed,
    required this.createdAt,
    required this.title,
    this.bodyText,
    this.imageSeed,
    required this.upvotes,
    required this.commentCount,
    this.saved = false,
    this.joined = false,
    this.voteState = 0,
    this.comments = const [],
  });

  String get timeAgo {
    final diff = DateTime.now().difference(createdAt);
    if (diff.inDays > 0) return '${diff.inDays}d';
    if (diff.inHours > 0) return '${diff.inHours}h';
    if (diff.inMinutes > 0) return '${diff.inMinutes}m';
    return 'now';
  }

  String get formattedVotes => _format(upvotes);
  String get formattedComments => _format(commentCount);

  static String _format(int n) {
    if (n >= 1000) return '${(n / 1000).toStringAsFixed(1)}k';
    return '$n';
  }
}
