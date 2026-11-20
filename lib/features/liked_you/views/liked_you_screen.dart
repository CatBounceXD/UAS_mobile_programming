import 'package:flutter/material.dart';

import '../data/dummy_liked_users.dart';
import '../models/liked_user_model.dart';
import '../widgets/liked_user_card.dart';
import '../widgets/match_dialog.dart';

class LikedYouScreen extends StatefulWidget {
  const LikedYouScreen({super.key});

  @override
  State<LikedYouScreen> createState() => _LikedYouScreenState();
}

class _LikedYouScreenState extends State<LikedYouScreen> {
  final List<LikedUserModel> _likedUsers = List.from(dummyLikedUsers);
  bool _isHighlightMode = false;
  bool _onlyVerified = false;

  List<LikedUserModel> get _displayedUsers {
    if (!_onlyVerified) return _likedUsers;
    return _likedUsers.where((user) => user.isVerified).toList();
  }

  void _toggleHighlightMode() {
    setState(() {
      _isHighlightMode = !_isHighlightMode;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isHighlightMode
              ? 'Mode lihat aktif: klik kartu untuk melihat detail profil.'
              : 'Mode lihat dinonaktifkan.',
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _passUser(LikedUserModel user) {
    setState(() {
      _likedUsers.removeWhere((item) => item.id == user.id);
    });
  }

  void _likeBackUser(LikedUserModel user) {
    setState(() {
      _likedUsers.removeWhere((item) => item.id == user.id);
    });

    showDialog<void>(
      context: context,
      builder: (_) => MatchDialog(matchedUser: user),
    );
  }

  void _resetDummyData() {
    setState(() {
      _likedUsers
        ..clear()
        ..addAll(dummyLikedUsers);
      _onlyVerified = false;
      _isHighlightMode = false;
    });
  }

  void _onCardTap(LikedUserModel user) {
    final hasPhoto = user.photoUrl.trim().isNotEmpty;
    final initial = user.name.isNotEmpty ? user.name[0].toUpperCase() : '?';

    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: kBumbleYellow.withValues(alpha: 0.35),
                    backgroundImage: hasPhoto
                        ? NetworkImage(user.photoUrl)
                        : null,
                    child: hasPhoto
                        ? null
                        : Text(
                            initial,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: kDarkText,
                            ),
                          ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${user.name}, ${user.age}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${user.occupation} • ${user.distanceKm} km away',
                          style: const TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Text(user.bio, style: const TextStyle(fontSize: 14, height: 1.4)),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.pop(sheetContext);
                        _passUser(user);
                      },
                      icon: const Icon(Icons.close),
                      label: const Text('Pass'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kBumbleYellow,
                        foregroundColor: kDarkText,
                      ),
                      onPressed: () {
                        Navigator.pop(sheetContext);
                        _likeBackUser(user);
                      },
                      icon: const Icon(Icons.favorite),
                      label: const Text('Like Back'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final users = _displayedUsers;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Liked You',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            tooltip: 'Mode lihat profil',
            onPressed: _toggleHighlightMode,
            icon: Icon(
              _isHighlightMode ? Icons.visibility : Icons.visibility_outlined,
              color: _isHighlightMode ? kDarkText : null,
            ),
          ),
          IconButton(
            tooltip: 'Reset data dummy',
            onPressed: _resetDummyData,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${users.length} orang menyukaimu',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                FilterChip(
                  label: const Text('Verified'),
                  selected: _onlyVerified,
                  onSelected: (value) => setState(() => _onlyVerified = value),
                ),
              ],
            ),
          ),
          Expanded(
            child: users.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Belum ada profil yang ditampilkan.',
                          style: TextStyle(color: Colors.black54),
                        ),
                        const SizedBox(height: 10),
                        TextButton(
                          onPressed: _resetDummyData,
                          child: const Text('Muat ulang data'),
                        ),
                      ],
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: users.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.72,
                        ),
                    itemBuilder: (context, index) {
                      final user = users[index];
                      return LikedUserCard(
                        user: user,
                        isHighlightMode: _isHighlightMode,
                        onTap: () => _onCardTap(user),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
