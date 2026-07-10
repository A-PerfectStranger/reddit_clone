import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'screens/main_navigation_screen.dart';

/// Punto de entrada de la aplicación.
///
/// Proyecto académico: Clon de Reddit 100% offline, construido con
/// widgets nativos de Flutter y datos simulados localmente (sin
/// conexión a la API real de Reddit ni WebViews).
void main() {
  runApp(const RedditCloneApp());
}

class RedditCloneApp extends StatelessWidget {
  const RedditCloneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reddit Clone - UI Móvil',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.light,
      home: const MainNavigationScreen(),
    );
  }
}
