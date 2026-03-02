import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app/app_state.dart';
import '../../models/book.dart';

class DownloadsPage extends StatelessWidget {
  const DownloadsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    final cs = Theme.of(context).colorScheme;

    final downloaded = demoBooks.where((b) => app.isDownloaded(b.id)).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Downloads')),
      body: downloaded.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  'No downloads yet.\nOpen a book and tap Download.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: cs.onSurfaceVariant, height: 1.4),
                ),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: downloaded.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, i) {
                final book = downloaded[i];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(backgroundColor: book.accent.withValues(alpha: 0.2), child: Icon(Icons.download_done_rounded, color: book.accent)),
                    title: Text(book.title),
                    subtitle: Text(book.author),
                    trailing: IconButton(
                      tooltip: 'Remove',
                      onPressed: () => app.removeDownload(book.id),
                      icon: Icon(Icons.delete_outline_rounded, color: cs.error),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
