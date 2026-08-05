import 'package:flutter/material.dart';
import 'screens/profile_setup_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const WgicApp());
}

class WgicApp extends StatelessWidget {
  const WgicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WGIC',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: const ProfileSetupScreen(),
    );
  }
}
