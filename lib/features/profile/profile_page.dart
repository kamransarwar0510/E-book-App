import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app/app_state.dart';
import '../../models/book.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    final cs = Theme.of(context).colorScheme;

    final downloadedCount = demoBooks.where((b) => app.isDownloaded(b.id)).length;
    final bookmarkedCount = demoBooks.fold<int>(0, (sum, b) => sum + app.bookmarksFor(b.id).length);

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: cs.primaryContainer,
                    child: Icon(Icons.person_rounded, color: cs.onPrimaryContainer, size: 30),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Reader', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900)),
                        Text('Premium UI demo', style: TextStyle(color: cs.onSurfaceVariant)),
                      ],
                    ),
                  ),
                  FilledButton.tonal(
                    onPressed: () {},
                    child: const Text('Edit'),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 14),

          Row(
            children: [
              Expanded(
                child: _StatCard(label: 'Books', value: '${demoBooks.length}', icon: Icons.library_books_rounded),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatCard(label: 'Downloads', value: '$downloadedCount', icon: Icons.download_rounded),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _StatCard(label: 'Bookmarks', value: '$bookmarkedCount', icon: Icons.bookmarks_rounded),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatCard(label: 'Font scale', value: app.readerFontScale.toStringAsFixed(2), icon: Icons.text_fields_rounded),
              ),
            ],
          ),

          const SizedBox(height: 14),

          Card(
            child: ListTile(
              leading: const Icon(Icons.stars_rounded),
              title: const Text('Tips to make it even more premium'),
              subtitle: const Text('Add real EPUB/PDF support, sync, and a cloud library.'),
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.label, required this.value, required this.icon});

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: cs.primaryContainer,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: cs.onPrimaryContainer),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(value, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900)),
                  Text(label, style: TextStyle(color: cs.onSurfaceVariant)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
