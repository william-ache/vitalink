import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  final int _selectedIndex = 1; // Citas
  int _selectedDayIndex = 0; // Oct 14

  final List<Map<String, String>> _days = [
    {'day': 'Lun', 'date': '14'},
    {'day': 'Mar', 'date': '15'},
    {'day': 'Mié', 'date': '16'},
    {'day': 'Jue', 'date': '17'},
    {'day': 'Vie', 'date': '18'},
    {'day': 'Sáb', 'date': '19'},
  ];

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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Citas',
                          style: GoogleFonts.manrope(
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              'Octubre 2024',
                              style: TextStyle(color: AppTheme.primaryTeal, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(width: 4),
                            const Icon(Icons.calendar_month, color: AppTheme.primaryTeal, size: 20),
                          ],
                        ),
                      ],
                    ).animate().fadeIn(),
                    
                    const SizedBox(height: 24),
                    _buildHorizontalDatePicker(),
                    
                    const SizedBox(height: 32),
                    Text(
                      'PROGRAMADAS PARA HOY',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: Colors.grey.shade500,
                        letterSpacing: 1,
                      ),
                    ).animate().fadeIn(delay: 300.ms),
                    
                    const SizedBox(height: 16),
                    _buildAppointmentCard(
                      doctorName: 'Dr. Aris Thorne',
                      specialty: 'Cardiología',
                      time: '09:30 AM',
                      image: 'https://i.pravatar.cc/150?u=dr1',
                      delay: 400,
                    ),
                    const SizedBox(height: 16),
                    _buildAppointmentCard(
                      doctorName: 'Dra. Elena Vance',
                      specialty: 'Medicina General',
                      time: '02:15 PM',
                      image: 'https://i.pravatar.cc/150?u=dr2',
                      delay: 600,
                    ),
                    
                    const SizedBox(height: 24),
                    Center(
                      child: TextButton(
                        onPressed: () {},
                        child: const Text('Ver 3 más en Octubre', style: TextStyle(color: AppTheme.primaryTeal, fontWeight: FontWeight.bold)),
                      ),
                    ).animate().fadeIn(delay: 800.ms),
                    
                    const SizedBox(height: 20),
                    _buildBookButton().animate().fadeIn(delay: 1000.ms).scale(),
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

  Widget _buildHorizontalDatePicker() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _days.asMap().entries.map((entry) {
          int idx = entry.key;
          Map<String, String> dayData = entry.value;
          bool isSelected = _selectedDayIndex == idx;
          
          return GestureDetector(
            onTap: () => setState(() => _selectedDayIndex = idx),
            child: AnimatedContainer(
              duration: 200.ms,
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              decoration: BoxDecoration(
                color: isSelected ? AppTheme.primaryTeal : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: isSelected ? AppTheme.primaryTeal : Colors.grey.shade200),
                boxShadow: isSelected ? [BoxShadow(color: AppTheme.primaryTeal.withValues(alpha: 0.2), blurRadius: 8, offset: const Offset(0, 4))] : [],
              ),
              child: Column(
                children: [
                  Text(
                    dayData['day']!,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey.shade500,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    dayData['date']!,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                    ),
                  ),
                  if (isSelected)
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      width: 4,
                      height: 4,
                      decoration: const BoxDecoration(color: AppTheme.secondaryGreen, shape: BoxShape.circle),
                    ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    ).animate().fadeIn(delay: 200.ms).slideX(begin: 0.1);
  }

  Widget _buildAppointmentCard({
    required String doctorName,
    required String specialty,
    required String time,
    required String image,
    required int delay,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Stack(
                children: [
                  CircleAvatar(radius: 28, backgroundImage: NetworkImage(image)),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                      child: const Icon(Icons.check_circle, color: AppTheme.secondaryGreen, size: 16),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(doctorName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
                      child: Text(specialty, style: TextStyle(color: Colors.grey.shade600, fontSize: 11, fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(time.split(' ')[0], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  Text(time.split(' ')[1], style: TextStyle(color: Colors.grey.shade500, fontSize: 11, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(height: 1),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    side: BorderSide(color: AppTheme.primaryTeal.withValues(alpha: 0.3)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Reprogramar', style: TextStyle(color: AppTheme.primaryTeal, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFEBEE),
                    foregroundColor: const Color(0xFFD32F2F),
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Cancelar', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(delay: delay.ms).slideY(begin: 0.1);
  }

  Widget _buildBookButton() {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: AppTheme.primaryTeal,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: AppTheme.primaryTeal.withValues(alpha: 0.3), blurRadius: 15, offset: const Offset(0, 8)),
        ],
      ),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(16),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, color: Colors.white),
            SizedBox(width: 10),
            Text('Agendar nueva cita', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
          ],
        ),
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
