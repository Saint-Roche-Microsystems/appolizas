import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:polizas/core/config/environment_config.dart';
import 'themes/general_theme.dart';
import 'views/main_view.dart';

void main() async {
  await EnvironmentConfig.load();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sistema de Seguros',
      debugShowCheckedModeBanner: false,
      theme: getGeneralTheme(Brightness.light),
      home: const MainView(),
    );
  }
}