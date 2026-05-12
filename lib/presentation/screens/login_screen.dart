import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/vital_button.dart';
import '../../core/theme/app_theme.dart';
import '../../core/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLogin = true;
  bool _isLoading = false;
  int _selectedType = 0; // 0: Paciente, 1: Profesional, 2: Clínica

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  
  final AuthService _authService = AuthService();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _handleAuth() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showError('Por favor completa todos los campos');
      return;
    }

    setState(() => _isLoading = true);

    try {
      if (_isLogin) {
        await _authService.signIn(email, password);
      } else {
        final name = _nameController.text.trim();
        if (name.isEmpty) {
          _showError('Por favor ingresa tu nombre');
          setState(() => _isLoading = false);
          return;
        }
        await _authService.signUp(email, password, name);
      }
      if (mounted) context.go('/dashboard');
    } catch (e) {
      _handleAuthError(e);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _handleSocialAuth(String provider) async {
    _showError('Próximamente: Primero probemos el correo manual');
  }

  void _handleAuthError(dynamic e) {
    String message = 'Ocurrió un error inesperado';
    final errStr = e.toString().toLowerCase();
    
    if (errStr.contains('user-not-found') || errStr.contains('invalid-credential')) {
      message = 'Correo o contraseña incorrectos';
    } else if (errStr.contains('wrong-password')) {
      message = 'Contraseña incorrecta';
    } else if (errStr.contains('email-already-in-use')) {
      message = 'El correo ya está registrado';
    } else if (errStr.contains('weak-password')) {
      message = 'La contraseña es muy débil';
    } else if (errStr.contains('network-request-failed')) {
      message = 'Error de conexión';
    }
    
    _showError(message);
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: -100,
            right: -100,
            child: CircleAvatar(
              radius: 200,
              backgroundColor: AppTheme.primaryTeal.withValues(alpha: 0.03),
            ),
          ).animate().scale(duration: 2.seconds, curve: Curves.easeInOut),
          
          SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () => context.go('/welcome'),
                              child: const Icon(Icons.arrow_back_ios_new, size: 20, color: Colors.grey),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text('Ayuda', style: TextStyle(color: AppTheme.primaryTeal, fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: 5),
                        Center(
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/images/logo-removebg-preview.png', 
                                height: 160,
                              ).animate(onPlay: (controller) => controller.repeat(reverse: true))
                               .moveY(begin: -5, end: 5, duration: 2.seconds, curve: Curves.easeInOutSine),
                            ],
                          ),
                        ),
                        
                        const SizedBox(height: 10),
                        
                        Text(
                          _isLogin ? 'Bienvenido' : 'Crea tu cuenta',
                          style: GoogleFonts.manrope(
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            color: AppTheme.primaryTeal,
                          ),
                        ).animate().fadeIn().slideX(begin: -0.1),
                        
                        Text(
                          _isLogin ? 'Accede a tu portal de salud integral' : 'Únete a la red de salud más avanzada',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppTheme.neutralGray),
                        ).animate().fadeIn(delay: 200.ms),
                        
                        const SizedBox(height: 32),
                        _buildAccountTypeSelector().animate().fadeIn(delay: 300.ms).slideY(begin: 0.1),
                        
                        const SizedBox(height: 32),
                        
                        if (!_isLogin) ...[
                          _buildAppInput('Nombre Completo', Icons.person_outline, 'Ej. Juan Pérez', controller: _nameController)
                              .animate().fadeIn(delay: 400.ms),
                          const SizedBox(height: 20),
                        ],
                        
                        _buildAppInput('Correo electrónico', Icons.email_outlined, 'nombre@ejemplo.com', controller: _emailController)
                            .animate().fadeIn(delay: 500.ms),
                        
                        const SizedBox(height: 20),
                        
                        _buildAppInput(
                          'Contraseña', 
                          Icons.lock_outline, 
                          'Mínimo 8 caracteres',
                          isPassword: true,
                          controller: _passwordController,
                          trailing: _isLogin ? GestureDetector(
                            onTap: () {},
                            child: const Text('¿Olvidaste?', style: TextStyle(color: AppTheme.primaryTeal, fontWeight: FontWeight.bold, fontSize: 12)),
                          ) : null,
                        ).animate().fadeIn(delay: 600.ms),
                        
                        const SizedBox(height: 40),
                        
                        _isLoading 
                          ? const Center(child: CircularProgressIndicator(color: AppTheme.primaryTeal))
                          : VitalButton(
                              label: _isLogin ? 'Iniciar Sesión' : 'Registrarse',
                              onPressed: _handleAuth,
                            ).animate().scale(delay: 700.ms, begin: const Offset(0.95, 0.95)),
                        
                        const SizedBox(height: 30),
                        Center(
                          child: Text(
                            'o continuar con',
                            style: TextStyle(color: Colors.grey.shade400, fontSize: 13),
                          ),
                        ).animate().fadeIn(delay: 800.ms),
                        
                        const SizedBox(height: 24),
                        _buildSocialRow().animate().fadeIn(delay: 900.ms).slideY(begin: 0.1),
                        
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(_isLogin ? '¿No tienes una cuenta? ' : '¿Ya tienes una cuenta? '),
                              GestureDetector(
                                onTap: () => setState(() => _isLogin = !_isLogin),
                                child: Text(
                                  _isLogin ? 'Regístrate' : 'Inicia sesión',
                                  style: const TextStyle(color: AppTheme.primaryTeal, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ).animate().fadeIn(delay: 1.seconds),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountTypeSelector() {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          _typeTab(0, 'Paciente'),
          _typeTab(1, 'Profesional'),
          _typeTab(2, 'Clínica'),
        ],
      ),
    );
  }

  Widget _typeTab(int index, String label) {
    bool isSelected = _selectedType == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedType = index),
        child: AnimatedContainer(
          duration: 250.ms,
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            boxShadow: isSelected ? [
              BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 4, offset: const Offset(0, 2)),
            ] : [],
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isSelected ? AppTheme.primaryTeal : Colors.grey.shade600,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 13,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppInput(String label, IconData icon, String hint, {bool isPassword = false, Widget? trailing, TextEditingController? controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            if (trailing != null) trailing,
          ],
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: TextField(
            controller: controller,
            obscureText: isPassword,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
              prefixIcon: Icon(icon, color: AppTheme.primaryTeal, size: 20),
              suffixIcon: isPassword ? Icon(Icons.visibility_off_outlined, color: Colors.grey.shade300, size: 20) : null,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialRow() {
    return Row(
      children: [
        _socialBtn(Icons.g_mobiledata, 'Google', const Color(0xFFEA4335), () => _handleSocialAuth('google')),
        const SizedBox(width: 16),
        _socialBtn(Icons.apple, 'Apple', Colors.black, () => _handleSocialAuth('apple')),
      ],
    );
  }

  Widget _socialBtn(IconData icon, String label, Color color, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.03),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: color.withValues(alpha: 0.1)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 24, color: color),
              const SizedBox(width: 8),
              Text(label, style: TextStyle(fontWeight: FontWeight.bold, color: color)),
            ],
          ),
        ),
      ),
    );
  }
}
