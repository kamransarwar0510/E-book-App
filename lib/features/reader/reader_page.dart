import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app/app_state.dart';
import '../../models/book.dart';

class ReaderPage extends StatefulWidget {
  const ReaderPage({super.key, required this.bookId});
  final String bookId;

  @override
  State<ReaderPage> createState() => _ReaderPageState();
}

class _ReaderPageState extends State<ReaderPage> {
  late final PageController _controller;

  @override
  void initState() {
    super.initState();
    final app = context.read<AppState>();
    final initial = app.lastPageFor(widget.bookId);
    _controller = PageController(initialPage: initial);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    final book = demoBooks.firstWhere((b) => b.id == widget.bookId);

    final cs = Theme.of(context).colorScheme;

    final readerColors = _readerPalette(context, app.readerTheme);

    return Theme(
      data: Theme.of(context).copyWith(
        scaffoldBackgroundColor: readerColors.background,
        appBarTheme: Theme.of(context).appBarTheme.copyWith(
              backgroundColor: readerColors.background,
              foregroundColor: readerColors.onBackground,
              surfaceTintColor: readerColors.background,
            ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(book.title),
          actions: [
            IconButton(
              tooltip: 'Reader settings',
              onPressed: () => _openReaderSheet(context),
              icon: const Icon(Icons.tune_rounded),
            ),
          ],
        ),
        body: PageView.builder(
          controller: _controller,
          itemCount: book.chapters.length,
          onPageChanged: (page) => app.setLastPage(book.id, page),
          itemBuilder: (context, page) {
            final textScale = app.readerFontScale;
            final isMarked = app.isBookmarked(book.id, page);

            return Padding(
              padding: const EdgeInsets.fromLTRB(18, 10, 18, 18),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Chapter ${page + 1} / ${book.chapters.length}',
                        style: TextStyle(
                          color: readerColors.onBackground.withValues(alpha: 0.75),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        tooltip: isMarked ? 'Remove bookmark' : 'Bookmark page',
                        onPressed: () => app.toggleBookmark(book.id, page),
                        icon: Icon(isMarked ? Icons.bookmark_rounded : Icons.bookmark_add_outlined),
                        color: isMarked ? cs.primary : readerColors.onBackground,
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  Expanded(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: readerColors.card,
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 22,
                            offset: const Offset(0, 12),
                            color: Colors.black.withValues(alpha: app.readerTheme == ReaderTheme.night ? 0.35 : 0.10),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
                        child: SingleChildScrollView(
                          child: Text(
                            book.chapters[page],
                            textScaleFactor: textScale,
                            style: TextStyle(
                              height: 1.55,
                              fontSize: 16,
                              color: readerColors.onCard,
                              letterSpacing: 0.1,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  LinearProgressIndicator(
                    value: (page + 1) / book.chapters.length,
                    minHeight: 6,
                    borderRadius: BorderRadius.circular(99),
                    backgroundColor: readerColors.onBackground.withValues(alpha: 0.12),
                    color: cs.primary,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _openReaderSheet(BuildContext context) async {
    final app = context.read<AppState>();

    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        final cs = Theme.of(context).colorScheme;

        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 18),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Reader',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 14),

              Text('Font size', style: TextStyle(color: cs.onSurfaceVariant)),
              Slider(
                value: app.readerFontScale,
                min: 0.85,
                max: 1.35,
                divisions: 10,
                label: app.readerFontScale.toStringAsFixed(2),
                onChanged: (v) => app.setReaderFontScale(v),
              ),

              const SizedBox(height: 6),
              Text('Theme', style: TextStyle(color: cs.onSurfaceVariant)),
              const SizedBox(height: 8),

              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _themeChip(context, 'Paper', ReaderTheme.paper, app.readerTheme),
                  _themeChip(context, 'Sepia', ReaderTheme.sepia, app.readerTheme),
                  _themeChip(context, 'Night', ReaderTheme.night, app.readerTheme),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _themeChip(BuildContext context, String label, ReaderTheme value, ReaderTheme current) {
    final selected = value == current;
    final palette = _readerPalette(context, value);

    return ChoiceChip(
      selected: selected,
      label: Text(label),
      onSelected: (_) => context.read<AppState>().setReaderTheme(value),
      avatar: Container(
        width: 18,
        height: 18,
        decoration: BoxDecoration(
          color: palette.card,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: palette.onCard.withValues(alpha: 0.2)),
        ),
      ),
    );
  }
}

class _ReaderColors {
  const _ReaderColors({
    required this.background,
    required this.onBackground,
    required this.card,
    required this.onCard,
  });

  final Color background;
  final Color onBackground;
  final Color card;
  final Color onCard;
}

_ReaderColors _readerPalette(BuildContext context, ReaderTheme theme) {
  final cs = Theme.of(context).colorScheme;

  switch (theme) {
    case ReaderTheme.paper:
      return _ReaderColors(
        background: cs.surface,
        onBackground: cs.onSurface,
        card: cs.surfaceContainerLowest,
        onCard: cs.onSurface,
      );
    case ReaderTheme.sepia:
      return const _ReaderColors(
        background: Color(0xFFFFF6E8),
        onBackground: Color(0xFF3B2F2A),
        card: Color(0xFFFFFBF3),
        onCard: Color(0xFF3B2F2A),
      );
    case ReaderTheme.night:
      return const _ReaderColors(
        background: Color(0xFF0F1115),
        onBackground: Color(0xFFE8EAF0),
        card: Color(0xFF161A22),
        onCard: Color(0xFFE8EAF0),
      );
  }
}
