import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../app/app_state.dart';
import '../../models/book.dart';
import '../../widgets/book_cover.dart';

class BookDetailsPage extends StatelessWidget {
  const BookDetailsPage({super.key, required this.bookId});
  final String bookId;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final book = demoBooks.firstWhere((b) => b.id == bookId);
    final app = context.watch<AppState>();

    final downloaded = app.isDownloaded(book.id);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 320,
            title: Text(book.title),
            actions: [
              IconButton(
                tooltip: 'Share',
                onPressed: () {},
                icon: const Icon(Icons.ios_share_rounded),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [book.accent.withValues(alpha: 0.45), cs.surface],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: SizedBox(
                        width: 162,
                        height: 228,
                        child: BookCover(
                          heroTag: 'cover_${book.id}',
                          accent: book.accent,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 26),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w900,
                          letterSpacing: -0.6,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(book.author, style: TextStyle(color: cs.onSurfaceVariant)),
                  const SizedBox(height: 14),

                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      ...book.tags.map((t) => Chip(label: Text(t))),
                      Chip(label: Text('${book.pages} pages')),
                      Chip(label: Text('${book.chapters.length} chapters')),
                    ],
                  ),

                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: () => context.push('/library/read/${book.id}'),
                          icon: const Icon(Icons.play_arrow_rounded),
                          label: const Text('Read'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      FilledButton.tonalIcon(
                        onPressed: () {
                          if (downloaded) {
                            app.removeDownload(book.id);
                          } else {
                            app.downloadBook(book.id);
                          }
                        },
                        icon: Icon(downloaded ? Icons.download_done_rounded : Icons.download_rounded),
                        label: Text(downloaded ? 'Downloaded' : 'Download'),
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),
                  Text(
                    'About',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    book.description,
                    style: TextStyle(color: cs.onSurfaceVariant, height: 1.5),
                  ),

                  const SizedBox(height: 18),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.bookmarks_rounded),
                      title: const Text('View bookmarks'),
                      subtitle: const Text('See saved pages across your library'),
                      trailing: const Icon(Icons.chevron_right_rounded),
                      onTap: () => context.push('/library/bookmarks'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
