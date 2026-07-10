import 'package:flutter/material.dart';
import '../models/subreddit.dart';
import '../services/fake_data_service.dart';
import '../widgets/community_card.dart';
import '../widgets/loading_skeleton.dart';

/// Pantalla de Comunidades: lista vertical de subreddits con opción de
/// unirse/salir (Join), usando [ListView.builder] para performance óptima
/// incluso con 60+ elementos.
class CommunitiesScreen extends StatefulWidget {
  const CommunitiesScreen({super.key});

  @override
  State<CommunitiesScreen> createState() => _CommunitiesScreenState();
}

class _CommunitiesScreenState extends State<CommunitiesScreen> {
  final _service = FakeDataService.instance;
  List<Subreddit> _communities = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final data = await _service.fetchCommunities();
    setState(() {
      _communities = data;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Comunidades')),
      body: _isLoading
          ? ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: 6,
              itemBuilder: (context, index) => const PostCardSkeleton(),
            )
          : RefreshIndicator(
              onRefresh: _load,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: _communities.length,
                itemBuilder: (context, index) {
                  final subreddit = _communities[index];
                  return CommunityCard(
                    key: ValueKey(subreddit.id),
                    subreddit: subreddit,
                    onJoinToggle: () {
                      setState(() => _service.toggleJoin(subreddit));
                    },
                  );
                },
              ),
            ),
    );
  }
}
