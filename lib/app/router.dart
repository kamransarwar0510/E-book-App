import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/splash/splash_page.dart';
import '../features/onboarding/onboarding_page.dart';
import '../features/library/library_page.dart';
import '../features/book_details/book_details_page.dart';
import '../features/reader/reader_page.dart';
import '../features/bookmarks/bookmarks_page.dart';
import '../features/downloads/downloads_page.dart';
import '../features/settings/settings_page.dart';
import '../features/profile/profile_page.dart';
import 'app_state.dart';

GoRouter buildRouter(AppState appState) {
  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: appState,
    routes: [
      GoRoute(
        path: '/splash',
        builder: (_, __) => const SplashPage(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (_, __) => const OnboardingPage(),
      ),
      GoRoute(
        path: '/library',
        builder: (_, __) => const LibraryPage(),
        routes: [
          GoRoute(
            path: 'book/:id',
            builder: (_, state) => BookDetailsPage(bookId: state.pathParameters['id']!),
          ),
          GoRoute(
            path: 'read/:id',
            builder: (_, state) => ReaderPage(bookId: state.pathParameters['id']!),
          ),
          GoRoute(
            path: 'bookmarks',
            builder: (_, __) => const BookmarksPage(),
          ),
          GoRoute(
            path: 'downloads',
            builder: (_, __) => const DownloadsPage(),
          ),
          GoRoute(
            path: 'settings',
            builder: (_, __) => const SettingsPage(),
          ),
          GoRoute(
            path: 'profile',
            builder: (_, __) => const ProfilePage(),
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) {
      return Scaffold(
        body: Center(
          child: Text('Route error: ${state.error}'),
        ),
      );
    },
  );
}
