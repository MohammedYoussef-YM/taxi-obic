import 'package:taxi_obic/utils/import.dart';

class LoginViewModel extends ChangeNotifier {
  final ApiService _apiService;
  TextEditingController phoneController = TextEditingController();
  final SharedPreferencesService _prefsService;
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  String? accessToken;

  LoginViewModel(this._apiService, this._prefsService);

  Future<void> login(context) async {
    try {
      accessToken = await _apiService.login(phoneController.text);
      print(accessToken);
      if (accessToken!.isNotEmpty){
        // حفظ حالة تسجيل الدخول
        await _prefsService.setLoggedIn(true);
        // التنقل إلى الشاشة الرئيسية
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
