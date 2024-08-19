import 'package:taxi_obic/utils/import.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColor.backGroundColor,
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
              child: const Column(
                children: [
                  Expanded(
                    flex: 9,
                    child: CustomSliderOnBoarding(),
                  ),
                  // يمكنك إضافة عناصر أخرى هنا إذا لزم الأمر
                  Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          CustomDotControllerOnBoarding(),
                          Spacer(flex: 1),
                          // CustomButtonOnBoarding()
                        ],
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
