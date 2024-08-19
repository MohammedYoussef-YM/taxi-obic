import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  Future<void> saveCredentials(String accessToken, String phoneNumber) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('accessToken', accessToken);
      await prefs.setString('phoneNumber', phoneNumber);
    } catch (e) {
      print('Error saving credentials: $e');
      print('Error saving credentials: $e');
      print('Error saving credentials: $e');
    }
  }

  Future<Map<String, String?>> getCredentials() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return {
      'accessToken': prefs.getString('accessToken'),
      'phoneNumber': prefs.getString('phoneNumber'),
    };
  }

  Future<void> clearCredentials() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('accessToken');
    await prefs.remove('phoneNumber');
  }
}
