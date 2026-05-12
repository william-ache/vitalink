import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.primaryTeal),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Notificaciones',
          style: GoogleFonts.manrope(
            color: Colors.black,
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.grey),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Hoy',
                  style: GoogleFonts.manrope(fontSize: 22, fontWeight: FontWeight.w800),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Marcar como leído', style: TextStyle(color: AppTheme.primaryTeal, fontSize: 12, fontWeight: FontWeight.bold)),
                ),
              ],
            ).animate().fadeIn(),
            
            const SizedBox(height: 12),
            _buildNotificationCard(
              icon: Icons.calendar_month,
              iconColor: Colors.white,
              bgColor: AppTheme.primaryTeal,
              title: 'Recordatorio de cita',
              time: 'Hace 5 min',
              description: 'Mañana a las 10:30 AM con el Dr. Roberto Valdés.',
              delay: 100,
            ),
            const SizedBox(height: 12),
            _buildNotificationCard(
              icon: Icons.description,
              iconColor: Colors.white,
              bgColor: AppTheme.secondaryGreen,
              title: 'Nuevo Resultado',
              time: 'Hace 2 h',
              description: 'Tu informe de \'Analítica General\' ya está disponible para descargar.',
              hasBadge: true,
              delay: 200,
            ),
            
            const SizedBox(height: 32),
            Text(
              'Anterior',
              style: GoogleFonts.manrope(fontSize: 22, fontWeight: FontWeight.w800),
            ).animate().fadeIn(delay: 300.ms),
            
            const SizedBox(height: 12),
            _buildNotificationCard(
              icon: Icons.chat_bubble_outline,
              iconColor: Colors.grey.shade700,
              bgColor: Colors.grey.shade200,
              title: 'Nuevo Mensaje',
              time: 'Ayer',
              description: 'El Dr. Aris Thorne te ha enviado un mensaje.',
              delay: 400,
            ),
            const SizedBox(height: 12),
            _buildNotificationCard(
              icon: Icons.stay_current_portrait,
              iconColor: Colors.grey.shade700,
              bgColor: Colors.grey.shade200,
              title: 'Actualización de Sistema',
              time: 'Hace 2 d',
              description: 'Vitalink se ha actualizado a la versión 2.4.1.',
              delay: 500,
            ),
            
            const SizedBox(height: 32),
            
            // Health Tip Banner
            Container(
              width: double.infinity,
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                image: const DecorationImage(
                  image: NetworkImage('https://images.unsplash.com/photo-1576091160550-2173dba999ef?q=80&w=1000&auto=format&fit=crop'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(Colors.black38, BlendMode.darken),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(8)),
                      child: const Text('Consejo de Salud', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Mantén tus registros al día',
                      style: GoogleFonts.manrope(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w800),
                    ),
                    const Text(
                      'Una gestión eficiente de tus resultados ayuda a un diagnóstico más rápido.',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.1),
            
            const SizedBox(height: 16),
            
            // Privacy Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFF9E6445), // Brownish color from image
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  const Icon(Icons.shield_outlined, color: Colors.white, size: 40),
                  const SizedBox(height: 16),
                  Text(
                    'Tu Privacidad',
                    style: GoogleFonts.manrope(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Tus datos médicos están encriptados de extremo a extremo.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF9E6445),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    ),
                    child: const Text('Ver Seguridad', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ).animate().fadeIn(delay: 700.ms).slideY(begin: 0.1),
            
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationCard({
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
    required String title,
    required String time,
    required String description,
    bool hasBadge = false,
    required int delay,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                        if (hasBadge) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(color: AppTheme.primaryTeal, borderRadius: BorderRadius.circular(6)),
                            child: const Text('NUEVO', style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ],
                    ),
                    Text(time, style: TextStyle(color: Colors.grey.shade500, fontSize: 10, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 13, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: delay.ms).slideX(begin: 0.05);
  }
}
