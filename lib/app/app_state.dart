import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppThemeMode { system, light, dark }

enum ReaderTheme { paper, sepia, night }

class AppState extends ChangeNotifier {
  static const _kSeenOnboarding = 'seen_onboarding';
  static const _kThemeMode = 'theme_mode';
  static const _kUseDynamicColor = 'use_dynamic_color';
  static const _kReaderFontScale = 'reader_font_scale';
  static const _kReaderTheme = 'reader_theme';

  late SharedPreferences _prefs;

  bool _seenOnboarding = false;
  AppThemeMode _themeMode = AppThemeMode.system;
  bool _useDynamicColor = true;

  double _readerFontScale = 1.0; // 0.85 - 1.35
  ReaderTheme _readerTheme = ReaderTheme.paper;

  // Book states (simple demo persistence)
  final Set<String> _downloadedBookIds = {};
  final Map<String, Set<int>> _bookmarks = {}; // bookId -> pages
  final Map<String, int> _lastPage = {}; // bookId -> page

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();

    _seenOnboarding = _prefs.getBool(_kSeenOnboarding) ?? false;
    _useDynamicColor = _prefs.getBool(_kUseDynamicColor) ?? true;

    final themeIdx = _prefs.getInt(_kThemeMode) ?? AppThemeMode.system.index;
    _themeMode = AppThemeMode.values[themeIdx.clamp(0, AppThemeMode.values.length - 1)];

    _readerFontScale = (_prefs.getDouble(_kReaderFontScale) ?? 1.0).clamp(0.85, 1.35);

    final readerThemeIdx = _prefs.getInt(_kReaderTheme) ?? ReaderTheme.paper.index;
    _readerTheme = ReaderTheme.values[readerThemeIdx.clamp(0, ReaderTheme.values.length - 1)];

    // Demo: downloaded/bookmarks/lastPage kept in-memory for simplicity.
    // (You can persist them with JSON in SharedPreferences later.)
  }

  bool get seenOnboarding => _seenOnboarding;
  AppThemeMode get themeMode => _themeMode;
  bool get useDynamicColor => _useDynamicColor;

  double get readerFontScale => _readerFontScale;
  ReaderTheme get readerTheme => _readerTheme;

  bool isDownloaded(String bookId) => _downloadedBookIds.contains(bookId);
  Set<int> bookmarksFor(String bookId) => _bookmarks[bookId] ?? <int>{};
  int lastPageFor(String bookId) => _lastPage[bookId] ?? 0;

  Future<void> setSeenOnboarding(bool value) async {
    _seenOnboarding = value;
    await _prefs.setBool(_kSeenOnboarding, value);
    notifyListeners();
  }

  Future<void> setThemeMode(AppThemeMode mode) async {
    _themeMode = mode;
    await _prefs.setInt(_kThemeMode, mode.index);
    notifyListeners();
  }

  Future<void> setUseDynamicColor(bool value) async {
    _useDynamicColor = value;
    await _prefs.setBool(_kUseDynamicColor, value);
    notifyListeners();
  }

  Future<void> setReaderFontScale(double scale) async {
    _readerFontScale = scale.clamp(0.85, 1.35);
    await _prefs.setDouble(_kReaderFontScale, _readerFontScale);
    notifyListeners();
  }

  Future<void> setReaderTheme(ReaderTheme theme) async {
    _readerTheme = theme;
    await _prefs.setInt(_kReaderTheme, theme.index);
    notifyListeners();
  }

  // Downloads
  void downloadBook(String bookId) {
    _downloadedBookIds.add(bookId);
    notifyListeners();
  }

  void removeDownload(String bookId) {
    _downloadedBookIds.remove(bookId);
    notifyListeners();
  }

  // Bookmarks
  void toggleBookmark(String bookId, int page) {
    final set = _bookmarks.putIfAbsent(bookId, () => <int>{});
    if (set.contains(page)) {
      set.remove(page);
    } else {
      set.add(page);
    }
    notifyListeners();
  }

  bool isBookmarked(String bookId, int page) => bookmarksFor(bookId).contains(page);

  // Reading progress
  void setLastPage(String bookId, int page) {
    _lastPage[bookId] = page;
    notifyListeners();
  }

  ThemeMode get materialThemeMode {
    switch (_themeMode) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
        return ThemeMode.system;
    }
  }
}
