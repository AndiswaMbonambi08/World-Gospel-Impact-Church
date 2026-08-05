import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Displays the WGIC logo centered at the top of the screen.
/// Swap the Container placeholder below for:
///   Image.asset('assets/images/wgic_logo_white.png', height: 40)
class LogoHeader extends StatelessWidget {
  final double height;
  final bool onDarkBackground;

  const LogoHeader({
    super.key,
    this.height = 90,
    this.onDarkBackground = true,
  });

  @override
  Widget build(BuildContext context) {
    final bg = onDarkBackground ? AppTheme.black : AppTheme.white;
    final fg = onDarkBackground ? AppTheme.white : AppTheme.black;

    return Container(
      width: double.infinity,
      height: height,
      color: bg,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/Worldgospelimpactchurch122-removebg-preview.png',
            height: 40,
          ),
          const SizedBox(height: 4),
          Text(
            'World Gospel Impact Church',
            style: TextStyle(color: fg, fontSize: 10, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
