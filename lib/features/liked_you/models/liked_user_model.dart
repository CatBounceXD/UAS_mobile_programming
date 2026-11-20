class LikedUserModel {
  final String id;
  final String name;
  final int age;
  final String occupation;
  final String bio;
  final String photoUrl;
  final String likedAgo;
  final int distanceKm;
  final bool isVerified;

  const LikedUserModel({
    required this.id,
    required this.name,
    required this.age,
    required this.occupation,
    required this.bio,
    required this.likedAgo,
    required this.distanceKm,
    this.photoUrl = '',
    this.isVerified = false,
  });

  factory LikedUserModel.fromMap(Map<String, dynamic> map) {
    return LikedUserModel(
      id: map['id']?.toString() ?? '',
      name: map['name']?.toString() ?? 'Unknown',
      age: (map['age'] as int?) ?? 20,
      occupation: map['occupation']?.toString() ?? '-',
      bio: map['bio']?.toString() ?? '',
      photoUrl:
          map['photo_url']?.toString() ?? map['photoUrl']?.toString() ?? '',
      likedAgo:
          map['liked_ago']?.toString() ??
          map['likedAgo']?.toString() ??
          'Baru saja',
      distanceKm:
          (map['distance_km'] as int?) ?? (map['distanceKm'] as int?) ?? 1,
      isVerified:
          (map['is_verified'] as bool?) ??
          (map['isVerified'] as bool?) ??
          false,
    );
  }
}
