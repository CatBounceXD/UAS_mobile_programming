enum DiscoverCategory {
  recommended,
  similarInterests,
  sameGoals,
}

class DiscoverUserModel {
  final String id;
  final String name;
  final int age;
  final String? photoUrl;
  final List<String> badges;
  final DiscoverCategory category;
  final bool isVerified;
  final bool isLiked;

  const DiscoverUserModel({
    required this.id,
    required this.name,
    required this.age,
    this.photoUrl,
    required this.badges,
    required this.category,
    this.isVerified = false,
    this.isLiked = false,
  });

  DiscoverUserModel copyWith({
    String? id,
    String? name,
    int? age,
    String? photoUrl,
    List<String>? badges,
    DiscoverCategory? category,
    bool? isVerified,
    bool? isLiked,
  }) {
    return DiscoverUserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      photoUrl: photoUrl ?? this.photoUrl,
      badges: badges ?? this.badges,
      category: category ?? this.category,
      isVerified: isVerified ?? this.isVerified,
      isLiked: isLiked ?? this.isLiked,
    );
  }

  factory DiscoverUserModel.fromMap(Map<String, dynamic> map) {
    return DiscoverUserModel(
      id: map['id']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
      age: (map['age'] as num?)?.toInt() ?? 18,
      photoUrl: map['photoUrl']?.toString(),
      badges: List<String>.from(map['badges'] ?? const []),
      category: DiscoverCategory.values.firstWhere(
        (e) => e.name == map['category'],
        orElse: () => DiscoverCategory.recommended,
      ),
      isVerified: map['isVerified'] as bool? ?? false,
      isLiked: map['isLiked'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'photoUrl': photoUrl,
      'badges': badges,
      'category': category.name,
      'isVerified': isVerified,
      'isLiked': isLiked,
    };
  }
}