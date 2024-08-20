import 'package:taxi_obic/utils/import.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await determinePosition();
  final prefs = await SharedPreferences.getInstance();
  final SharedPreferencesService sharedPreferencesService = SharedPreferencesService();

  final bool onBoardingSeen = prefs.getBool('onBoardingSeen') ?? false;
  final bool isLoggedIn = await sharedPreferencesService.isLoggedIn();

  runApp(MyApp(
    onBoardingSeen: onBoardingSeen,
    isLoggedIn: isLoggedIn,
  ));
}

class MyApp extends StatelessWidget {
  final bool onBoardingSeen;
  final bool isLoggedIn;

  const MyApp({super.key, required this.onBoardingSeen, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => SharedPreferencesService()),
        Provider(create: (context) => ApiService(context.read<SharedPreferencesService>())),
        ChangeNotifierProvider(create: (_) => ValidationProvider()),
        ChangeNotifierProvider<OnBoardingViewModel>(create: (context) => OnBoardingViewModel(context.read<SharedPreferencesService>())),
        ChangeNotifierProvider(create: (context) => LoginViewModel(context.read<ApiService>(), context.read<SharedPreferencesService>())),
        ChangeNotifierProvider(create: (_) => TaxiDriverDetailsViewModel()),
        ChangeNotifierProvider<ConfirmTaxiBookViewModel>(create: (context) => ConfirmTaxiBookViewModel(context.read<ApiService>(),context.read<SharedPreferencesService>()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Taxi',
        initialRoute: isLoggedIn ? AppRoute.home : (onBoardingSeen ? AppRoute.login : AppRoute.onBoarding),
        routes: appRoutes,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
      ),
    );
  }
}