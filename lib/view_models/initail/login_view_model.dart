import 'package:taxi_obic/utils/import.dart';

class LoginViewModel extends ChangeNotifier {
  final ApiService _apiService;
  final SharedPreferencesService _prefsService;
  TextEditingController phoneController = TextEditingController();
  String? accessToken;

  LoginViewModel(this._apiService, this._prefsService);

  Future<void> login(context) async {
    try {
      accessToken = await _apiService.login(phoneController.text);
      print("accessToken = ");
      print(accessToken);
      if (accessToken!.isNotEmpty){
        // حفظ حالة تسجيل الدخول
        await _prefsService.setLoggedIn(true);
        // التنقل إلى الشاشة الرئيسية
        Navigator.pushNamedAndRemoveUntil(
          context, '/home',  // Replace with your home route
              (Route<dynamic> route) => false,  // This removes all the previous routes
        );
      }
      notifyListeners();
    } catch (e) {
      _showTaxiInfoDialog(context,e);
      print('Error: $e');
    }
  }

  void _showTaxiInfoDialog(BuildContext context,error) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Column(
            children: [
              Text(
                'Error',
                style: TextStyle(fontSize: 16,color: AppColor.red, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                'This phone number not found',
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          content: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xffF3A205),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Ok',style: TextStyle(
                color: AppColor.blackButton,
                fontWeight: FontWeight.bold,
                fontSize: 16)),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }
}
