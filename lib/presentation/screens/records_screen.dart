import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';

class RecordsScreen extends StatefulWidget {
  const RecordsScreen({super.key});

  @override
  State<RecordsScreen> createState() => _RecordsScreenState();
}

class _RecordsScreenState extends State<RecordsScreen> {
  final int _selectedIndex = 2; // Historia Clínica

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9F9),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      'Historia Clínica',
                      style: GoogleFonts.manrope(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ).animate().fadeIn().slideX(begin: -0.1),
                    Text(
                      'Accede a tus registros médicos personales',
                      style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
                    ).animate().fadeIn(delay: 200.ms),
                    
                    const SizedBox(height: 24),
                    _buildSearchBar(),
                    
                    const SizedBox(height: 24),
                    _buildFilterTabs(),
                    
                    const SizedBox(height: 24),
                    
                    // Records List
                    _buildLabResultCard().animate().fadeIn(delay: 600.ms).slideY(begin: 0.1),
                    const SizedBox(height: 16),
                    _buildConsultationCard().animate().fadeIn(delay: 800.ms).slideY(begin: 0.1),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildWhatsAppStyleBottomNav(),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset('assets/images/icono.png', height: 40),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_none_outlined, color: Colors.black87),
                onPressed: () => context.push('/notifications'),
              ),
              const SizedBox(width: 4),
              const CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=juan_vitalink'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Buscar por doctor o diagnóstico',
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
          prefixIcon: Icon(Icons.search, color: Colors.grey.shade400),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }

  Widget _buildFilterTabs() {
    final filters = ['Consultas', 'Resultados Lab', 'Recetas', 'Imágenes'];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: filters.map((filter) {
          bool isActive = filter == 'Consultas';
          return Container(
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: isActive ? AppTheme.primaryTeal : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              filter,
              style: TextStyle(
                color: isActive ? Colors.white : Colors.grey.shade600,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildLabResultCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: const Color(0xFFFFE0D0), borderRadius: BorderRadius.circular(12)),
                child: const Icon(Icons.biotech, color: Color(0xFFC36D4B), size: 24),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Resultados Lab', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text('Oct 12, 2023', style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
                ],
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: AppTheme.secondaryGreen.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(8)),
                child: const Text('NUEVO', style: TextStyle(color: AppTheme.primaryTeal, fontSize: 10, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text('Conteo Sanguíneo Completo (CSC)', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18, color: AppTheme.primaryTeal)),
          const SizedBox(height: 8),
          Text(
            'Examen estándar para determinar el estado general de salud y detectar diversos trastornos...',
            style: TextStyle(color: Colors.grey.shade600, fontSize: 14, height: 1.4),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.picture_as_pdf, size: 18),
                  label: const Text('Descargar PDF', style: TextStyle(fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryTeal,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade200), borderRadius: BorderRadius.circular(12)),
                child: const Icon(Icons.visibility_outlined, color: AppTheme.primaryTeal, size: 22),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildConsultationCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: const Color(0xFFE0F7F9), borderRadius: BorderRadius.circular(12)),
                child: const Icon(Icons.medical_services_outlined, color: AppTheme.primaryTeal, size: 24),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Consulta General', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text('Sep 28, 2023', style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const CircleAvatar(radius: 12, backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=sarah')),
              const SizedBox(width: 8),
              Text('Dra. Sarah Thompson', style: TextStyle(color: Colors.grey.shade700, fontWeight: FontWeight.w600, fontSize: 14)),
            ],
          ),
          const SizedBox(height: 12),
          const Text('Seguimiento de fatiga post-viral', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18, color: AppTheme.primaryTeal)),
          const SizedBox(height: 8),
          Text(
            'El paciente reporta una mejora significativa en los niveles de energía. Se recomienda continuar con suplementos...',
            style: TextStyle(color: Colors.grey.shade600, fontSize: 14, height: 1.4),
          ),
        ],
      ),
    );
  }

  Widget _buildWhatsAppStyleBottomNav() {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200, width: 0.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _whatsAppNavItem(0, Icons.home_rounded, 'Inicio', '/dashboard'),
          _whatsAppNavItem(1, Icons.calendar_today_rounded, 'Citas', '/appointments'),
          _whatsAppNavItem(2, Icons.assignment_outlined, 'Historia Clínica', '/records'),
          _whatsAppNavItem(3, Icons.chat_bubble_rounded, 'Chat Médico', '/messages', badgeCount: 2),
          _whatsAppNavItem(4, Icons.person_outline_rounded, 'Perfil', '/profile'),
        ],
      ),
    );
  }

  Widget _whatsAppNavItem(int index, IconData icon, String label, String route, {int? badgeCount}) {
    bool isSelected = _selectedIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (index != _selectedIndex) context.go(route);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(icon, color: isSelected ? AppTheme.primaryTeal : Colors.black87, size: 26),
                if (badgeCount != null)
                  Positioned(
                    right: -4,
                    top: -4,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(color: AppTheme.secondaryGreen, shape: BoxShape.circle),
                      child: Text(badgeCount.toString(), style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold)),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(color: isSelected ? AppTheme.primaryTeal : Colors.black87, fontSize: 10, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}
