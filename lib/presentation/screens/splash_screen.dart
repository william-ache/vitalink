import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_theme.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Navigate to Welcome after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (context.mounted) context.go('/welcome');
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background Decorative Elements
          Positioned(
            top: -50,
            left: -50,
            child: CircleAvatar(
              radius: 100,
              backgroundColor: AppTheme.primaryTeal.withValues(alpha: 0.05),
            ),
          ).animate().scale(duration: 2000.ms, curve: Curves.easeInOutSine),
          
          Positioned(
            bottom: -80,
            right: -80,
            child: CircleAvatar(
              radius: 150,
              backgroundColor: AppTheme.secondaryGreen.withValues(alpha: 0.05),
            ),
          ).animate().scale(duration: 2500.ms, curve: Curves.easeInOutSine),

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo-removebg-preview.png',
                  height: 180,
                ).animate()
                 .fadeIn(duration: 1000.ms)
                 .scale(begin: const Offset(0.8, 0.8), curve: Curves.elasticOut, duration: 1500.ms)
                 .shimmer(delay: 1500.ms, duration: 1500.ms),
                
                const SizedBox(height: 40),
                
                SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    color: AppTheme.primaryTeal.withValues(alpha: 0.5),
                  ),
                ).animate().fadeIn(delay: 1000.ms),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
