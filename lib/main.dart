import 'package:taxi_obic/utils/import.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await determinePosition(); // Ensure this function is defined in geolocator_service.dart
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => SharedPreferencesService()),
        Provider(create: (context) => ApiService(context.read<SharedPreferencesService>())),
        ChangeNotifierProvider(create: (context) => LoginViewModel(context.read<ApiService>())),
        ChangeNotifierProvider(create: (_) => TaxiDriverDetailsViewModel()),
        // ChangeNotifierProvider(create: (_) => DriverDetailsViewModel()),
        ChangeNotifierProvider<ConfirmTaxiBookViewModel>(create: (context) => ConfirmTaxiBookViewModel(context.read<ApiService>(),context.read<SharedPreferencesService>()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Taxi',
        initialRoute: AppRoute.onBoarding,
        routes: appRoutes,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
      ),
    );
  }
}