import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb_app/helpers/appearance.dart';
import 'package:tmdb_app/helpers/routes.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRoutes.routerConfig,
      theme: AppThemes.light,
      title: 'TMDB App',
      debugShowCheckedModeBanner: false,
    );
  }
}
