import 'dart:ui';

class Book {
  const Book({
    required this.id,
    required this.title,
    required this.author,
    required this.tags,
    required this.description,
    required this.accent,
    required this.pages,
    required this.chapters,
  });

  final String id;
  final String title;
  final String author;
  final List<String> tags;
  final String description;
  final Color accent;
  final int pages;
  final List<String> chapters;
}

const demoBooks = <Book>[
  Book(
    id: 'purple-1',
    title: 'Neon Orchid',
    author: 'A. Rivera',
    tags: ['Sci‑Fi', 'City', 'Fast'],
    pages: 34,
    accent: Color(0xFF7C4DFF),
    description:
        'A sleek sci‑fi novella with bright ideas, short chapters, and a calm reading flow. Perfect for demoing a premium reader UI.',
    chapters: [
      'Chapter 1\n\nThe city never slept; it simply blinked in gradients.',
      'Chapter 2\n\nShe traced the neon lines like constellations on glass.',
      'Chapter 3\n\nEvery signal had a story; every story had a key.',
      'Chapter 4\n\nThe elevator hummed—soft, like a secret.',
    ],
  ),
  Book(
    id: 'amber-2',
    title: 'Paper & Gold',
    author: 'M. Chen',
    tags: ['Design', 'Notes', 'Soft'],
    pages: 42,
    accent: Color(0xFFFFB300),
    description:
        'A warm, minimal collection of thoughts on focus, craft, and building beautiful systems—one page at a time.',
    chapters: [
      'Chapter 1\n\nDesign is what happens when you care about the last 10%.',
      'Chapter 2\n\nSmall spacing changes can make a screen feel expensive.',
      'Chapter 3\n\nConsistency is kindness to the reader.',
      'Chapter 4\n\nIf it reads well, it feels fast.',
      'Chapter 5\n\nLet the content breathe.',
    ],
  ),
  Book(
    id: 'teal-3',
    title: 'Quiet Oceans',
    author: 'S. Patel',
    tags: ['Fiction', 'Calm', 'Night'],
    pages: 28,
    accent: Color(0xFF26A69A),
    description:
        'A calm, night-friendly story built for testing typography, themes, and bookmarks in your reader.',
    chapters: [
      'Chapter 1\n\nAt midnight, the water looked like ink.',
      'Chapter 2\n\nA lighthouse turned slowly, like a metronome.',
      'Chapter 3\n\nHe wrote the tide times in the margin of an old book.',
    ],
  ),
];
