import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Guardar o actualizar datos del usuario
  Future<void> saveUserData({
    required String uid,
    required String name,
    required String email,
    String? bloodType,
    String? weight,
    String? height,
    List<String>? allergies,
    List<String>? chronicDiseases,
    String role = 'patient',
  }) async {
    try {
      await _db.collection('users').doc(uid).set({
        'uid': uid,
        'name': name,
        'email': email,
        'role': role,
        'bloodType': bloodType ?? '',
        'weight': weight ?? '',
        'height': height ?? '',
        'allergies': allergies ?? [],
        'chronicDiseases': chronicDiseases ?? [],
        'updatedAt': FieldValue.serverTimestamp(),
        'createdAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true)); // Merge evita que se borren datos si solo actualizas uno
    } catch (e) {
      print('Error al guardar datos en Firestore: $e');
      rethrow;
    }
  }

  // Leer los datos de un usuario
  Future<DocumentSnapshot> getUserData(String uid) async {
    return await _db.collection('users').doc(uid).get();
  }
}
