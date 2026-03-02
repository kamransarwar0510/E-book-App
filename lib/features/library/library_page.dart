import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../models/book.dart';
import '../../widgets/book_cover.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  String _query = '';
  String _tag = 'All';

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final tags = <String>{'All', ...demoBooks.expand((b) => b.tags)}.toList();

    final filtered = demoBooks.where((b) {
      final q = _query.trim().toLowerCase();
      final matchesQuery = q.isEmpty ||
          b.title.toLowerCase().contains(q) ||
          b.author.toLowerCase().contains(q) ||
          b.tags.any((t) => t.toLowerCase().contains(q));
      final matchesTag = _tag == 'All' || b.tags.contains(_tag);
      return matchesQuery && matchesTag;
    }).toList();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 150,
            title: const Text('Library'),
            actions: [
              IconButton(
                tooltip: 'Bookmarks',
                onPressed: () => context.push('/library/bookmarks'),
                icon: const Icon(Icons.bookmarks_rounded),
              ),
              IconButton(
                tooltip: 'Downloads',
                onPressed: () => context.push('/library/downloads'),
                icon: const Icon(Icons.download_rounded),
              ),
              IconButton(
                tooltip: 'Settings',
                onPressed: () => context.push('/library/settings'),
                icon: const Icon(Icons.settings_rounded),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [cs.primaryContainer.withValues(alpha: 0.85), cs.surface],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(108),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: Column(
                  children: [
                    SearchBar(
                      leading: const Icon(Icons.search_rounded),
                      hintText: 'Search books, authors, tags...',
                      onChanged: (v) => setState(() => _query = v),
                      trailing: [
                        if (_query.isNotEmpty)
                          IconButton(
                            onPressed: () => setState(() => _query = ''),
                            icon: const Icon(Icons.close_rounded),
                          ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 38,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, i) {
                          final t = tags[i];
                          final selected = t == _tag;
                          return ChoiceChip(
                            selected: selected,
                            label: Text(t),
                            onSelected: (_) => setState(() => _tag = t),
                          );
                        },
                        separatorBuilder: (_, __) => const SizedBox(width: 10),
                        itemCount: tags.length,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                childAspectRatio: 0.62,
              ),
              itemCount: filtered.length,
              itemBuilder: (context, i) {
                final book = filtered[i];
                return _BookTile(book: book);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/library/profile'),
        icon: const Icon(Icons.person_rounded),
        label: const Text('Profile'),
      ),
    );
  }
}

class _BookTile extends StatelessWidget {
  const _BookTile({required this.book});
  final Book book;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: () => context.push('/library/book/${book.id}'),
      child: Ink(
        decoration: BoxDecoration(
          color: cs.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              blurRadius: 18,
              offset: const Offset(0, 12),
              color: Colors.black.withValues(alpha: 0.12),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: BookCover(
                  heroTag: 'cover_${book.id}',
                  accent: book.accent,
                  borderRadius: 18,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    book.author,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: cs.onSurfaceVariant),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
