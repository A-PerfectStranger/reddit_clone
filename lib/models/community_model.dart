class CommunityModel {
  final String id;
  final String name;
  final String iconSeed;
  final int members;
  final String description;
  bool joined;

  CommunityModel({
    required this.id,
    required this.name,
    required this.iconSeed,
    required this.members,
    required this.description,
    this.joined = false,
  });

  String get formattedMembers {
    if (members >= 1000000) {
      return '${(members / 1000000).toStringAsFixed(1)}M members';
    } else if (members >= 1000) {
      return '${(members / 1000).toStringAsFixed(1)}K members';
    }
    return '$members members';
  }
}
