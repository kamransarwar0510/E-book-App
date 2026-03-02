import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app/app_state.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Appearance',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<AppThemeMode>(
                    value: app.themeMode,
                    decoration: const InputDecoration(labelText: 'Theme mode'),
                    items: const [
                      DropdownMenuItem(value: AppThemeMode.system, child: Text('System')),
                      DropdownMenuItem(value: AppThemeMode.light, child: Text('Light')),
                      DropdownMenuItem(value: AppThemeMode.dark, child: Text('Dark')),
                    ],
                    onChanged: (v) {
                      if (v != null) app.setThemeMode(v);
                    },
                  ),
                  const SizedBox(height: 10),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Dynamic color (Android 12+)'),
                    subtitle: const Text('Use wallpaper-based colors when available.'),
                    value: app.useDynamicColor,
                    onChanged: app.setUseDynamicColor,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 14),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Reader defaults',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(height: 8),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.text_fields_rounded),
                    title: const Text('Font size'),
                    subtitle: Text(app.readerFontScale.toStringAsFixed(2)),
                  ),
                  Slider(
                    value: app.readerFontScale,
                    min: 0.85,
                    max: 1.35,
                    divisions: 10,
                    onChanged: (v) => app.setReaderFontScale(v),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 14),

          Card(
            child: ListTile(
              leading: const Icon(Icons.info_outline_rounded),
              title: const Text('About this template'),
              subtitle: const Text('6+ screens: Splash, Onboarding, Library, Details, Reader, Bookmarks, Downloads, Settings, Profile'),
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}
