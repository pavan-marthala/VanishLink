class UserProfile {
  final String userId;
  final String vanishId;
  final String username;
  final String displayName;
  final String photoUrl;
  final String status;

  const UserProfile({
    required this.userId,
    required this.vanishId,
    required this.username,
    required this.displayName,
    required this.photoUrl,
    required this.status,
  });
}
