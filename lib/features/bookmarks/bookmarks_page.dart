import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../app/app_state.dart';
import '../../models/book.dart';

class BookmarksPage extends StatelessWidget {
  const BookmarksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    final cs = Theme.of(context).colorScheme;

    final items = <({Book book, int page})>[];
    for (final book in demoBooks) {
      for (final page in app.bookmarksFor(book.id)) {
        items.add((book: book, page: page));
      }
    }
    items.sort((a, b) => a.book.title.compareTo(b.book.title));

    return Scaffold(
      appBar: AppBar(title: const Text('Bookmarks')),
      body: items.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  'No bookmarks yet.\nOpen a book and tap the bookmark icon.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: cs.onSurfaceVariant, height: 1.4),
                ),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: items.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, i) {
                final item = items[i];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(backgroundColor: item.book.accent.withValues(alpha: 0.2), child: Icon(Icons.bookmark_rounded, color: item.book.accent)),
                    title: Text(item.book.title),
                    subtitle: Text('Chapter ${item.page + 1}'),
                    trailing: IconButton(
                      tooltip: 'Remove',
                      onPressed: () => app.toggleBookmark(item.book.id, item.page),
                      icon: const Icon(Icons.close_rounded),
                    ),
                    onTap: () => context.push('/library/read/${item.book.id}'),
                  ),
                );
              },
            ),
    );
  }
}
