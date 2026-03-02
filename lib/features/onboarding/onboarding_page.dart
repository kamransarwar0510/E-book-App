import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../app/app_state.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final _controller = PageController();
  int _index = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _finish() async {
    await context.read<AppState>().setSeenOnboarding(true);
    if (!mounted) return;
    context.go('/library');
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 8),
              child: Row(
                children: [
                  TextButton(
                    onPressed: _finish,
                    child: const Text('Skip'),
                  ),
                  const Spacer(),
                  FilledButton.tonal(
                    onPressed: () => context.go('/library'),
                    child: const Text('Preview'),
                  ),
                ],
              ),
            ),

            Expanded(
              child: PageView(
                controller: _controller,
                onPageChanged: (v) => setState(() => _index = v),
                children: const [
                  _OnboardCard(
                    icon: Icons.auto_stories_rounded,
                    title: 'A premium library',
                    subtitle: 'Search, filter, and organize books with a clean, modern layout.',
                  ),
                  _OnboardCard(
                    icon: Icons.palette_rounded,
                    title: 'Material 3 themes',
                    subtitle: 'Dynamic color + dark mode + reader themes (paper/sepia/night).',
                  ),
                  _OnboardCard(
                    icon: Icons.bookmarks_rounded,
                    title: 'Bookmarks & progress',
                    subtitle: 'Save pages, jump back instantly, and continue where you left off.',
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 18),
              child: Row(
                children: [
                  _Dots(activeIndex: _index),
                  const Spacer(),
                  FilledButton(
                    onPressed: () async {
                      if (_index < 2) {
                        await _controller.nextPage(
                          duration: const Duration(milliseconds: 280),
                          curve: Curves.easeOut,
                        );
                      } else {
                        await _finish();
                      }
                    },
                    child: Text(_index < 2 ? 'Next' : 'Get started'),
                  ),
                ],
              ),
            ),

            Container(height: 8, color: cs.surface),
          ],
        ),
      ),
    );
  }
}

class _OnboardCard extends StatelessWidget {
  const _OnboardCard({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 8, 18, 8),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 92,
                height: 92,
                decoration: BoxDecoration(
                  color: cs.primaryContainer,
                  borderRadius: BorderRadius.circular(26),
                ),
                child: Icon(icon, size: 44, color: cs.onPrimaryContainer),
              ),
              const SizedBox(height: 18),
              Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.6,
                    ),
              ),
              const SizedBox(height: 10),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(color: cs.onSurfaceVariant, height: 1.4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Dots extends StatelessWidget {
  const _Dots({required this.activeIndex});
  final int activeIndex;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Row(
      children: List.generate(3, (i) {
        final active = i == activeIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          margin: const EdgeInsets.only(right: 8),
          width: active ? 22 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: active ? cs.primary : cs.outlineVariant,
            borderRadius: BorderRadius.circular(99),
          ),
        );
      }),
    );
  }
}
