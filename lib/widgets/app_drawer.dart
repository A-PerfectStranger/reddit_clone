import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/community_provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final communities = context.watch<CommunityProvider>().communities;
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ListTile(
              leading: const Icon(Icons.trending_up_rounded),
              title: const Text('Popular'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.new_releases_outlined),
              title: const Text('Latest'),
              onTap: () => Navigator.pop(context),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.hub_outlined),
              title: const Text('Discover communities'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text('Start a community'),
              onTap: () => Navigator.pop(context),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text('Your Communities',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold)),
            ),
            ...communities.take(10).map(
                  (c) => ListTile(
                    dense: true,
                    leading: const Icon(Icons.circle, size: 22, color: Colors.grey),
                    title: Text('r/${c.name}'),
                    trailing: const Icon(Icons.star_border, size: 18),
                    onTap: () => Navigator.pop(context),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
