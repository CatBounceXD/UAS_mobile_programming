import 'package:flutter/material.dart';
import '../models/discover_user_model.dart';
import '../repositories/discover_repository.dart';
import '../widgets/discover_profile_card.dart';

class DiscoverScreen extends StatefulWidget {
  final DiscoverRepository? repository;

  const DiscoverScreen({super.key, this.repository});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  late final DiscoverRepository _repository;
  List<DiscoverUserModel> _profiles = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _repository = widget.repository ?? DummyDiscoverRepository();
    _loadProfiles();
  }

  Future<void> _loadProfiles() async {
    final data = await _repository.fetchDiscoverProfiles();
    if (!mounted) return;
    setState(() {
      _profiles = data;
      _isLoading = false;
    });
  }

  Future<void> _toggleLike(String id) async {
    final index = _profiles.indexWhere((item) => item.id == id);
    if (index == -1) return;

    final updatedStatus = !_profiles[index].isLiked;
    setState(() {
      _profiles[index] = _profiles[index].copyWith(isLiked: updatedStatus);
    });

    await _repository.toggleLikeProfile(id, updatedStatus);
  }

  void _showDiscoverInfo(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return const Padding(
          padding: EdgeInsets.fromLTRB(20, 8, 20, 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'How recommendations work',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Profiles in Discover are grouped by shared interests, dating goals, and profile activity. Swipe horizontally to explore more options.',
              ),
            ],
          ),
        );
      },
    );
  }

  List<DiscoverUserModel> _byCategory(DiscoverCategory category) {
    return _profiles.where((item) => item.category == category).toList();
  }

  Widget _buildSection({
    required BuildContext context,
    required String title,
    required DiscoverCategory category,
    String? subtitleNote,
  }) {
    final items = _byCategory(category);
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            title,
            style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: 315,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(width: 14),
            itemBuilder: (context, index) {
              final profile = items[index];
              return DiscoverProfileCard(
                profile: profile,
                onToggleLike: () => _toggleLike(profile.id),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Viewing ${profile.name}, ${profile.age}'),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
              );
            },
          ),
        ),
        if (subtitleNote != null) ...[
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  size: 16,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    subtitleNote,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: _loadProfiles,
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Discover',
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                  fontWeight: FontWeight.w800,
                                ),
                          ),
                          IconButton(
                            onPressed: () => _showDiscoverInfo(context),
                            icon: const Icon(Icons.help_outline),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildSection(
                      context: context,
                      title: 'Recommended for you',
                      category: DiscoverCategory.recommended,
                      subtitleNote: 'Based on your profile and past matches',
                    ),
                    const SizedBox(height: 24),
                    _buildSection(
                      context: context,
                      title: 'Similar interests',
                      category: DiscoverCategory.similarInterests,
                    ),
                    const SizedBox(height: 24),
                    _buildSection(
                      context: context,
                      title: 'Same dating goals',
                      category: DiscoverCategory.sameGoals,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}