import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../theme/app_them.dart';
import '../../theme/theme_cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'External appearance',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _ThemeOptionTile(
            title: 'Light theme',
            icon: Icons.wb_sunny_rounded,
            themeType: AppThemeType.light,
          ),
          _ThemeOptionTile(
            title: 'Dark theme',
            icon: Icons.nightlight_round,
            themeType: AppThemeType.dark,
          ),
          _ThemeOptionTile(
            title: 'OLED (dark) theme',
            icon: Icons.brightness_3_rounded,
            themeType: AppThemeType.oled,
          ),

          const Divider(height: 48),

          const Text(
            'about app',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('version OBD Ledger'),
            subtitle: const Text('1.0.0 (Beta)'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}


class _ThemeOptionTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final AppThemeType themeType;

  const _ThemeOptionTile({
    required this.title,
    required this.icon,
    required this.themeType,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isOled = Theme.of(context).scaffoldBackgroundColor == Colors.black;

    bool isActive = false;
    if (themeType == AppThemeType.light && !isDark) isActive = true;
    if (themeType == AppThemeType.dark && isDark && !isOled) isActive = true;
    if (themeType == AppThemeType.oled && isDark && isOled) isActive = true;

    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: isActive ? 2 : 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: isActive ? colorScheme.primary : Colors.transparent,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isActive ? colorScheme.primary : Colors.grey,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        trailing: isActive
            ? Icon(Icons.check_circle, color: colorScheme.primary)
            : null,
        onTap: () {
          context.read<ThemeCubit>().changeTheme(themeType);
        },
      ),
    );
  }
}