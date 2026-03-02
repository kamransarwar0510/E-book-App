import 'package:flutter/material.dart';

class BookCover extends StatelessWidget {
  const BookCover({
    super.key,
    required this.heroTag,
    required this.accent,
    this.icon = Icons.menu_book,
    this.borderRadius = 22,
  });

  final String heroTag;
  final Color accent;
  final IconData icon;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Hero(
      tag: heroTag,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                accent.withValues(alpha: 0.95),
                cs.tertiary.withValues(alpha: 0.85),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Icon(icon, size: 52, color: Colors.white.withValues(alpha: 0.95)),
          ),
        ),
      ),
    );
  }
}
