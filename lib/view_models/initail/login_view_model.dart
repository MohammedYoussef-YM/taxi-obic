import 'package:taxi_obic/utils/import.dart';

class LoginViewModel extends ChangeNotifier {
  final ApiService _apiService;
  TextEditingController phoneController = TextEditingController();
  String? accessToken;

  LoginViewModel(this._apiService);

  Future<void> login(context) async {
    try {
      accessToken = await _apiService.login(phoneController.text);
      if (accessToken!.isNotEmpty){
        Navigator.pushNamed(context, '/home');
      }
      notifyListeners();
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }
}
