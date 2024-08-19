import 'package:taxi_obic/utils/import.dart';

class OnBoardingViewModel extends ChangeNotifier {
  PageController pageController = PageController();
  int currentPage = 0;

  void onPageChanged(context,int index) {
    currentPage = index;
    notifyListeners();
  }

  void next(context) {
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
