import 'package:flutter/material.dart';

import '../data/dummy_liked_users.dart';
import '../models/liked_user_model.dart';

class LikedUserCard extends StatelessWidget {
  final LikedUserModel user;
  final bool isHighlightMode;
  final VoidCallback onTap;

  const LikedUserCard({
    required this.user,
    required this.isHighlightMode,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: isHighlightMode
              ? Border.all(color: kBumbleYellow, width: 2.5)
              : null,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            fit: StackFit.expand,
            children: [
              
              _CardBackground(user: user),

              const _BottomGradient(),

              Positioned(
                top: 10,
                left: 10,
                child: _TimeBadge(label: user.likedAgo),
              ),

              if (isHighlightMode)
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.visibility, color: kBumbleYellow, size: 12),
                        SizedBox(width: 4),
                        Text(
                          'Lihat',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              Positioned(
                left: 12,
                right: 12,
                bottom: 12,
                child: _UserCardInfo(user: user),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CardBackground extends StatelessWidget {
  final LikedUserModel user;

  const _CardBackground({required this.user});

  @override
  Widget build(BuildContext context) {
    if (user.photoUrl.trim().isNotEmpty) {
      return Image.network(
        user.photoUrl,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => _initialPlaceholder(),
      );
    }
    return _initialPlaceholder();
  }

  Widget _initialPlaceholder() {
    final initial = user.name.isNotEmpty ? user.name[0].toUpperCase() : '?';
    return Container(
      color: const Color(0xFFF3EFE6),
      child: Center(
        child: CircleAvatar(
          radius: 34,
          backgroundColor: kBumbleYellow.withValues(alpha: 0.35),
          child: Text(
            initial,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: kDarkText,
            ),
          ),
        ),
      ),
    );
  }
}

class _BottomGradient extends StatelessWidget {
  const _BottomGradient();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withValues(alpha: 0.08),
            Colors.transparent,
            Colors.black.withValues(alpha: 0.80),
          ],
        ),
      ),
    );
  }
}

class _TimeBadge extends StatelessWidget {
  final String label;

  const _TimeBadge({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: kBumbleYellow,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: kDarkText,
        ),
      ),
    );
  }
}

class _UserCardInfo extends StatelessWidget {
  final LikedUserModel user;

  const _UserCardInfo({required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Flexible(
              child: Text(
                '${user.name}, ${user.age}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (user.isVerified) ...[
              const SizedBox(width: 4),
              const Icon(Icons.verified, color: kBumbleYellow, size: 16),
            ],
          ],
        ),
        const SizedBox(height: 2),
        Text(
          '${user.distanceKm} km away',
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
      ],
    );
  }
}
