import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';

class UserRepository {
  final EncryptedSharedPreferences _prefs = EncryptedSharedPreferences();

  // Load data method
  Future<Map<String, String?>> loadData() async {
    return {
      'firstName': await _prefs.getString('firstName'),
      'lastName': await _prefs.getString('lastName'),
      'phone': await _prefs.getString('phone'),
      'email': await _prefs.getString('email'),
    };
  }

  // Save data method
  Future<void> saveData(String firstName, String lastName, String phone, String email) async {
    await _prefs.setString('firstName', firstName);
    await _prefs.setString('lastName', lastName);
    await _prefs.setString('phone', phone);
    await _prefs.setString('email', email);
  }
}