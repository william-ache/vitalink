import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';
import '../../core/services/auth_service.dart';
import '../../core/services/database_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final int _selectedIndex = 4; // Perfil
  final AuthService _authService = AuthService();
  final DatabaseService _dbService = DatabaseService();

  // Datos locales del usuario
  String _name = 'Cargando...';
  String _email = '...';
  String _bloodType = '--';
  String _weight = '--';
  String _height = '--';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final user = _authService.currentUser;
    if (user != null) {
      try {
        final doc = await _dbService.getUserData(user.uid);
        if (doc.exists) {
          final data = doc.data() as Map<String, dynamic>;
          setState(() {
            _name = data['name'] ?? user.displayName ?? 'Usuario';
            _email = data['email'] ?? user.email ?? '';
            _bloodType = data['bloodType'] ?? '--';
            _weight = data['weight'] ?? '--';
            _height = data['height'] ?? '--';
            _isLoading = false;
          });
        }
      } catch (e) {
        print('Error cargando datos: $e');
        setState(() => _isLoading = false);
      }
    }
  }

  void _showEditProfileDialog() {
    final bloodController = TextEditingController(text: _bloodType == '--' ? '' : _bloodType);
    final weightController = TextEditingController(text: _weight == '--' ? '' : _weight);
    final heightController = TextEditingController(text: _height == '--' ? '' : _height);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 24,
          left: 24,
          right: 24,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Actualizar Ficha Médica', style: GoogleFonts.manrope(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            _buildEditInput('Tipo de Sangre', 'Ej. O+', bloodController),
            const SizedBox(height: 16),
            _buildEditInput('Peso (kg)', 'Ej. 75', weightController, keyboardType: TextInputType.number),
            const SizedBox(height: 16),
            _buildEditInput('Altura (m)', 'Ej. 1.80', heightController, keyboardType: TextInputType.number),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final uid = _authService.currentUser!.uid;
                  await _dbService.saveUserData(
                    uid: uid,
                    name: _name,
                    email: _email,
                    bloodType: bloodController.text,
                    weight: weightController.text,
                    height: heightController.text,
                  );
                  Navigator.pop(context);
                  _loadUserData(); // Recargar datos
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryTeal,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text('Guardar Cambios', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildEditInput(String label, String hint, TextEditingController controller, {TextInputType? keyboardType}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.grey)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.grey.shade50,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9F9),
      body: SafeArea(
        child: _isLoading 
        ? const Center(child: CircularProgressIndicator(color: AppTheme.primaryTeal))
        : SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),
              
              // Profile Header
              Center(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AppTheme.primaryTeal, width: 2),
                          ),
                          child: const CircleAvatar(
                            radius: 60,
                            backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=juan_vitalink'),
                          ),
                        ),
                        Positioned(
                          bottom: 5,
                          right: 5,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(color: AppTheme.primaryTeal, shape: BoxShape.circle),
                            child: const Icon(Icons.camera_alt_rounded, color: Colors.white, size: 20),
                          ),
                        ),
                      ],
                    ).animate().scale(duration: 600.ms, curve: Curves.easeOutBack),
                    
                    const SizedBox(height: 16),
                    Text(
                      _name,
                      style: GoogleFonts.manrope(fontSize: 24, fontWeight: FontWeight.w800, color: Colors.black),
                    ).animate().fadeIn(delay: 200.ms),
                    
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(color: AppTheme.primaryTeal.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        _email,
                        style: const TextStyle(color: AppTheme.primaryTeal, fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ).animate().fadeIn(delay: 300.ms),

                    const SizedBox(height: 16),
                    TextButton.icon(
                      onPressed: _showEditProfileDialog,
                      icon: const Icon(Icons.edit_outlined, size: 18),
                      label: const Text('Editar Perfil Médico'),
                      style: TextButton.styleFrom(foregroundColor: AppTheme.primaryTeal),
                    ).animate().fadeIn(delay: 400.ms),
                  ],
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Stats Row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    _buildStatCard('SANGRE', _bloodType, delay: 400),
                    const SizedBox(width: 12),
                    _buildStatCard('ALTURA', _height.contains('m') ? _height : '${_height}m', delay: 500),
                    const SizedBox(width: 12),
                    _buildStatCard('PESO', _weight.contains('kg') ? _weight : '${_weight}kg', delay: 600),
                  ],
                ),
              ),
              
              const SizedBox(height: 32),
              
              _buildMenuSection(
                title: 'CONFIGURACIÓN DE CUENTA',
                items: [
                  {'icon': Icons.person_outline, 'label': 'Información Personal'},
                  {'icon': Icons.verified_user_outlined, 'label': 'Seguro Médico'},
                  {'icon': Icons.payment_outlined, 'label': 'Métodos de Pago'},
                ],
                delay: 700,
              ),
              
              const SizedBox(height: 24),
              
              _buildMenuSection(
                title: 'SEGURIDAD Y AYUDA',
                items: [
                  {'icon': Icons.security_outlined, 'label': 'Seguridad'},
                  {'icon': Icons.help_outline, 'label': 'Centro de Ayuda'},
                ],
                delay: 800,
              ),
              
              const SizedBox(height: 32),
              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: double.infinity,
                  child: TextButton.icon(
                    onPressed: () async {
                      await _authService.signOut();
                      if (mounted) context.go('/welcome');
                    },
                    icon: const Icon(Icons.logout_rounded, color: Colors.redAccent),
                    label: const Text(
                      'Cerrar Sesión',
                      style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.redAccent.withValues(alpha: 0.05),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                  ),
                ),
              ).animate().fadeIn(delay: 900.ms),
              
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildWhatsAppStyleBottomNav(),
    );
  }

  Widget _buildStatCard(String title, String value, {required int delay, Color? valueColor}) {
    // Limpiar visualmente si no hay datos
    String displayValue = (value == '--' || value == 'm' || value == 'kg') ? '--' : value;

    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 10, offset: const Offset(0, 4))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(color: Colors.grey.shade500, fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 0.5)),
            const SizedBox(height: 8),
            Text(displayValue, style: TextStyle(color: valueColor ?? Colors.black, fontWeight: FontWeight.w900, fontSize: 18)),
          ],
        ),
      ),
    ).animate().fadeIn(delay: delay.ms).slideY(begin: 0.1);
  }

  Widget _buildMenuSection({required String title, required List<Map<String, dynamic>> items, required int delay}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            title,
            style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w800, color: Colors.grey.shade500, letterSpacing: 1),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            children: items.asMap().entries.map((entry) {
              int idx = entry.key;
              var item = entry.value;
              bool isLast = idx == items.length - 1;
              
              return Column(
                children: [
                  ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: AppTheme.primaryTeal.withValues(alpha: 0.05), borderRadius: BorderRadius.circular(12)),
                      child: Icon(item['icon'] as IconData, color: AppTheme.primaryTeal, size: 22),
                    ),
                    title: Text(item['label'] as String, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                    trailing: const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
                    onTap: () {},
                  ),
                  if (!isLast)
                    Divider(height: 1, indent: 64, color: Colors.grey.shade100),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    ).animate().fadeIn(delay: delay.ms).slideY(begin: 0.05);
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
