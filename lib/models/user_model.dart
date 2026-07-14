class UserModel {
  final String id;
  final String username;
  final String avatarSeed;
  final int karma;
  final DateTime accountCreated;

  const UserModel({
    required this.id,
    required this.username,
    required this.avatarSeed,
    required this.karma,
    required this.accountCreated,
  });
}
