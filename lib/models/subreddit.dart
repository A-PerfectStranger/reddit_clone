/// Modelo que representa una comunidad (subreddit).
class Subreddit {
  final String id;
  final String name; // Ej: "r/flutterdev"
  final String description;
  final int memberCount;
  final int iconColorSeed;
  bool isJoined;

  Subreddit({
    required this.id,
    required this.name,
    required this.description,
    required this.memberCount,
    required this.iconColorSeed,
    this.isJoined = false,
  });
}
