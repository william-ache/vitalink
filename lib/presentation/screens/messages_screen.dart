import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  int _selectedIndex = 3; // Chat Médico

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
                    _buildSearchBar(),
                    
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Mensajes',
                          style: GoogleFonts.manrope(
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text('Marcar todo como leído', style: TextStyle(color: AppTheme.primaryTeal, fontWeight: FontWeight.bold, fontSize: 13)),
                        ),
                      ],
                    ).animate().fadeIn(),
                    
                    const SizedBox(height: 16),
                    
                    _buildChatCard(
                      name: 'Dr. Aris Thorne',
                      specialty: 'Cardiólogo',
                      message: 'Los análisis de sangre se ven estables, pe...',
                      time: '10:24 AM',
                      image: 'https://i.pravatar.cc/150?u=dr1',
                      isUnread: true,
                      delay: 200,
                    ),
                    const SizedBox(height: 12),
                    _buildChatCard(
                      name: 'Dra. Elena Vance',
                      specialty: 'Dermatóloga',
                      message: 'Deberías ver mejoras en las próximas...',
                      time: 'Ayer',
                      image: 'https://i.pravatar.cc/150?u=dr2',
                      isUnread: false,
                      delay: 400,
                    ),
                    const SizedBox(height: 12),
                    _buildChatCard(
                      name: 'Dr. Julian Marsh',
                      specialty: 'Pediatra',
                      message: 'He adjuntado el certificado de vacunación...',
                      time: '2:15 PM',
                      image: 'https://i.pravatar.cc/150?u=dr3',
                      isUnread: true,
                      isHighlighted: true,
                      delay: 600,
                    ),
                    const SizedBox(height: 12),
                    _buildChatCard(
                      name: 'Dra. Sarah Chen',
                      specialty: 'Médico General',
                      message: 'Por favor, avísame si los síntomas pers...',
                      time: 'Lunes',
                      image: 'https://i.pravatar.cc/150?u=dr4',
                      isUnread: true,
                      delay: 800,
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppTheme.primaryTeal,
        child: const Icon(Icons.add_comment_rounded, color: Colors.white),
      ).animate().scale(delay: 1000.ms),
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
          hintText: 'Buscar doctores, especialidades...',
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
          prefixIcon: Icon(Icons.search, color: Colors.grey.shade400),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }

  Widget _buildChatCard({
    required String name,
    required String specialty,
    required String message,
    required String time,
    required String image,
    required bool isUnread,
    bool isHighlighted = false,
    required int delay,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: isHighlighted ? Border.all(color: AppTheme.primaryTeal, width: 1) : Border.all(color: Colors.grey.shade100),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Row(
        children: [
          if (isHighlighted)
            Container(
              width: 4,
              height: 40,
              decoration: BoxDecoration(color: AppTheme.primaryTeal, borderRadius: BorderRadius.circular(2)),
            ),
          if (isHighlighted) const SizedBox(width: 12),
          Stack(
            children: [
              CircleAvatar(radius: 30, backgroundImage: NetworkImage(image)),
              if (isUnread)
                Positioned(
                  right: 2,
                  bottom: 2,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(color: AppTheme.secondaryGreen, shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2)),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Text(time, style: TextStyle(color: Colors.grey.shade500, fontSize: 11, fontWeight: FontWeight.bold)),
                  ],
                ),
                Text(specialty, style: const TextStyle(color: AppTheme.primaryTeal, fontSize: 12, fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(
                  message,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: isUnread ? Colors.black87 : Colors.grey.shade500, fontSize: 13, fontWeight: isUnread ? FontWeight.w600 : FontWeight.normal),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: delay.ms).slideX(begin: 0.05);
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
