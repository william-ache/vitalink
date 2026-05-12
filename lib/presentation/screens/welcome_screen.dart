import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_theme.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Top Image with Fade (Reduced height to save space)
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.35,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/doctor_onboarding.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.white.withValues(alpha: 0.6),
                        Colors.white,
                      ],
                      stops: const [0.5, 0.85, 1.0],
                    ),
                  ),
                ),
              ),
            ],
          ),
          
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Logo (Enlarged)
                  Image.asset(
                    'assets/images/logo-removebg-preview.png',
                    height: 130,
                  ).animate(onPlay: (controller) => controller.repeat(reverse: true))
                   .fadeIn(delay: 200.ms)
                   .scale()
                   .moveY(begin: -5, end: 5, duration: 2.seconds, curve: Curves.easeInOutSine),
                  
                  Column(
                    children: [
                      Text(
                        'Conectando Salud y Bienestar',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.neutralGray,
                        ),
                      ).animate().fadeIn(delay: 400.ms),
                    ],
                  ),
                  
                  // Feature Cards (Smaller)
                  Row(
                    children: [
                      _buildFeatureCard(
                        Icons.verified_user_outlined,
                        'Atención Personalizada',
                        delay: 600,
                      ),
                      const SizedBox(width: 12),
                      _buildFeatureCard(
                        Icons.group_outlined,
                        'Red de Expertos',
                        delay: 800,
                      ),
                    ],
                  ),
                  
                  Text(
                    'Gestiona tu salud con los mejores profesionales en segundos.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                      height: 1.3,
                    ),
                  ).animate().fadeIn(delay: 1000.ms),
                  
                  // Buttons
                  Column(
                    children: [
                      _buildGradientButton(context).animate().fadeIn(delay: 1200.ms).scale(),
                      const SizedBox(height: 12),
                      _buildOutlinedButton(context).animate().fadeIn(delay: 1400.ms),
                    ],
                  ),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('¿Eres profesional? ', style: TextStyle(fontSize: 12, color: Colors.grey)),
                      GestureDetector(
                        onTap: () {},
                        child: const Text(
                          'Únete aquí',
                          style: TextStyle(color: AppTheme.primaryTeal, fontWeight: FontWeight.bold, fontSize: 12, decoration: TextDecoration.underline),
                        ),
                      ),
                    ],
                  ).animate().fadeIn(delay: 1600.ms),
                  
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(IconData icon, String title, {required int delay}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
        decoration: BoxDecoration(
          color: AppTheme.primaryTeal.withValues(alpha: 0.03),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppTheme.primaryTeal.withValues(alpha: 0.05)),
        ),
        child: Column(
          children: [
            Icon(icon, color: AppTheme.primaryTeal, size: 22),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryTeal,
              ),
            ),
          ],
        ),
      ).animate().fadeIn(delay: delay.ms).slideY(begin: 0.1),
    );
  }

  Widget _buildGradientButton(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 52,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppTheme.primaryTeal, AppTheme.secondaryGreen],
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryTeal.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () => context.go('/login'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        child: const Text(
          'Comenzar',
          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildOutlinedButton(BuildContext context) {
    return OutlinedButton(
      onPressed: () => context.go('/login'),
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 52),
        side: const BorderSide(color: AppTheme.primaryTeal, width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      child: const Text(
        'Iniciar sesión',
        style: TextStyle(color: AppTheme.primaryTeal, fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }
}
