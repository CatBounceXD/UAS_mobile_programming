import '../models/discover_user_model.dart';

abstract class DiscoverRepository {
  Future<List<DiscoverUserModel>> fetchDiscoverProfiles();
  Future<void> toggleLikeProfile(String profileId, bool isLiked);
}

class DummyDiscoverRepository implements DiscoverRepository {
  final List<DiscoverUserModel> _profiles = [
    // Recommended for you (multiple options for horizontal slide)
    const DiscoverUserModel(
      id: '1',
      name: 'Nadia',
      age: 22,
      photoUrl: null,
      badges: ['Coffee', 'Casual chats'],
      category: DiscoverCategory.recommended,
      isVerified: true,
    ),
    const DiscoverUserModel(
      id: '2',
      name: 'Raka',
      age: 24,
      photoUrl: null,
      badges: ['Morning run', 'Movies'],
      category: DiscoverCategory.recommended,
    ),
    const DiscoverUserModel(
      id: '3',
      name: 'Clara',
      age: 23,
      photoUrl: null,
      badges: ['Bookstore', 'Art'],
      category: DiscoverCategory.recommended,
      isVerified: true,
    ),

    // Similar interests
    const DiscoverUserModel(
      id: '4',
      name: 'Salsa',
      age: 21,
      photoUrl: null,
      badges: ['Foodie'],
      category: DiscoverCategory.similarInterests,
      isVerified: true,
    ),
    const DiscoverUserModel(
      id: '5',
      name: 'Dimas',
      age: 23,
      photoUrl: null,
      badges: ['Indie music'],
      category: DiscoverCategory.similarInterests,
    ),
    const DiscoverUserModel(
      id: '6',
      name: 'Tara',
      age: 22,
      photoUrl: null,
      badges: ['Photography'],
      category: DiscoverCategory.similarInterests,
    ),

    // Same dating goals
    const DiscoverUserModel(
      id: '7',
      name: 'Keisha',
      age: 22,
      photoUrl: null,
      badges: ['New friends'],
      category: DiscoverCategory.sameGoals,
      isVerified: true,
    ),
    const DiscoverUserModel(
      id: '8',
      name: 'Leo',
      age: 25,
      photoUrl: null,
      badges: ['Long-term'],
      category: DiscoverCategory.sameGoals,
    ),
    const DiscoverUserModel(
      id: '9',
      name: 'Maya',
      age: 21,
      photoUrl: null,
      badges: ['Casual dates'],
      category: DiscoverCategory.sameGoals,
    ),
  ];

  @override
  Future<List<DiscoverUserModel>> fetchDiscoverProfiles() async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    return List<DiscoverUserModel>.from(_profiles);
  }

  @override
  Future<void> toggleLikeProfile(String profileId, bool isLiked) async {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    final index = _profiles.indexWhere((item) => item.id == profileId);
    if (index != -1) {
      _profiles[index] = _profiles[index].copyWith(isLiked: isLiked);
    }
  }
}