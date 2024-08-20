import 'package:taxi_obic/utils/import.dart';

class AppRoute {
  static const String onBoarding = '/';
  static const String login = '/login';
  static const String chooseRegistration = '/chooseRegistration';
  static const String home = '/home';
  // taxi route
  static const String taxi = '/taxi';
  static const String taxiDriverDetails = '/taxiDriverDetails';
  static const String confirmTaxiBook = '/confirmTaxiBook';
  // truck route
  static const String truck = '/truck';
  static const String truckDriverDetails = '/truckDriverDetails';
  static const String confirmTruckBook = '/confirmTruckBook';

  static const String doneBook = '/doneBook';
  static const String finalDoneBook = '/finalDoneBook';
}

Map<String, WidgetBuilder> appRoutes = {
  AppRoute.onBoarding: (context) => const OnBoarding(),
  AppRoute.chooseRegistration: (context) => const ChooseRegistrationScreen(),
  AppRoute.login: (context) => const LoginScreen(),
  AppRoute.home: (context) => const HomeView(),

  AppRoute.taxi: (context) => const TaxiView(),
  AppRoute.taxiDriverDetails: (context) => const TaxiDriverDetailsView(),
  AppRoute.confirmTaxiBook: (context) =>  ConfirmTaxiBookView(),

  AppRoute.truck: (context) => const TruckView(),
  AppRoute.truckDriverDetails: (context) => const TruckDriverDetailsView(),
  AppRoute.confirmTruckBook: (context) => const ConfirmTruckBookView(),
  // AppRoute.driver: (context) => const DriverDetailsView(),
  // AppRoute.confirmBook: (context) =>  ConfirmBookView(),
  AppRoute.doneBook: (context) => const DoneBookView(),
};
