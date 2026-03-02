import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../app/app_state.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _boot();
  }

  Future<void> _boot() async {
    await Future<void>.delayed(const Duration(milliseconds: 700));
    if (!mounted) return;

    final app = context.read<AppState>();
    context.go(app.seenOnboarding ? '/library' : '/onboarding');
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [cs.primaryContainer, cs.surface],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 78,
                height: 78,
                decoration: BoxDecoration(
                  color: cs.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 24,
                      offset: const Offset(0, 14),
                      color: Colors.black.withValues(alpha: 0.16),
                    ),
                  ],
                ),
                child: Icon(Icons.menu_book_rounded, color: cs.primary, size: 40),
              ),
              const SizedBox(height: 14),
              Text(
                'Lumen Reader',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.5,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'Beautiful reading, delightful UI',
                style: TextStyle(color: cs.onSurfaceVariant),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(strokeWidth: 2.6, color: cs.primary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
