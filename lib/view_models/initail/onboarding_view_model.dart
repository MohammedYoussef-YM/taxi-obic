import 'package:taxi_obic/utils/import.dart';

class OnBoardingViewModel extends ChangeNotifier {
  PageController pageController = PageController();
  int currentPage = 0;
  final SharedPreferencesService prefs;
  OnBoardingViewModel(this.prefs);

  void onPageChanged(context,int index) {
    currentPage = index;
    notifyListeners();
  }

  void next(BuildContext context) {
    if (currentPage == 2) {  // على افتراض أن هناك 3 صفحات في الـ OnBoarding
      prefs.setOnBoardingSeen();  // حفظ حالة عرض الشاشة
      Navigator.pushReplacementNamed(context, AppRoute.chooseRegistration);
    } else {
      pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  // void next(context) {
  //   Navigator.pushReplacementNamed(context, '/login');
  // }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
