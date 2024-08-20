import 'package:taxi_obic/utils/import.dart';

class ChooseRegistrationScreen extends StatelessWidget {
  const ChooseRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.contain,
              image: AssetImage(AppImageAsset.taxi)
            )
          ),
          child: Container(
            decoration: const BoxDecoration(
              color: Color(0xE3000000)
            ),
            child: ChangeNotifierProvider(
              create: (context) => OnBoardingViewModel(context.read<SharedPreferencesService>()),
              child: const ChooseRegistrationContent(),
            ),
          ),
        ),
      ),
    );
  }
}