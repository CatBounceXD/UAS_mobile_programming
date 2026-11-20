import 'package:flutter/material.dart';

import '../data/dummy_liked_users.dart';
import '../models/liked_user_model.dart';

class MatchDialog extends StatelessWidget {
  final LikedUserModel matchedUser;

  const MatchDialog({required this.matchedUser, super.key});

  @override
  Widget build(BuildContext context) {
    final hasPhoto = matchedUser.photoUrl.trim().isNotEmpty;
    final initial = matchedUser.name.isNotEmpty
        ? matchedUser.name[0].toUpperCase()
        : '?';

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: kBumbleYellow.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                "IT'S A MATCH!",
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.1,
                  color: kDarkText,
                ),
              ),
            ),
            const SizedBox(height: 16),
            CircleAvatar(
              radius: 48,
              backgroundColor: kBumbleYellow.withValues(alpha: 0.3),
              backgroundImage: hasPhoto
                  ? NetworkImage(matchedUser.photoUrl)
                  : null,
              child: hasPhoto
                  ? null
                  : Text(
                      initial,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: kDarkText,
                      ),
                    ),
            ),
            const SizedBox(height: 14),
            Text(
              'Kamu dan ${matchedUser.name}, ${matchedUser.age} saling match!',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Kirim pesan pertama sekarang sebelum waktunya habis.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black54, fontSize: 13),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kBumbleYellow,
                  foregroundColor: kDarkText,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  'Mulai Chat',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
