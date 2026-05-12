import 'package:firebase_auth/firebase_auth.dart';
import 'database_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseService _dbService = DatabaseService();

  // Stream para saber si el usuario está logueado o no
  Stream<User?> get user => _auth.authStateChanges();

  // Obtener el usuario actual de forma síncrona
  User? get currentUser => _auth.currentUser;

  // Registro con Email, Contraseña y Nombre
  Future<UserCredential?> signUp(String email, String password, String name) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      final String uid = userCredential.user!.uid;

      // 1. GUARDAR EL NOMBRE EN EL PERFIL DE AUTH
      await userCredential.user?.updateDisplayName(name);
      
      // 2. CREAR EL DOCUMENTO EN FIRESTORE (LA FICHA MÉDICA)
      await _dbService.saveUserData(
        uid: uid,
        name: name,
        email: email,
      );

      await userCredential.user?.reload();
      
      return userCredential;
    } on FirebaseAuthException catch (e) {
      print('Error en Registro: ${e.code}');
      rethrow;
    }
  }

  // Login con Email y Contraseña
  Future<UserCredential?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      print('Error en Login: ${e.code}');
      rethrow;
    }
  }

  // Cerrar Sesión
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
