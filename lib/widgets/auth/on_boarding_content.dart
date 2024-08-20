import 'package:taxi_obic/utils/import.dart';

class OnBoardingContent extends StatelessWidget {
  const OnBoardingContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        // عرض معلومات السلايد
        Expanded(
          flex: 9,
          child: CustomSliderOnBoarding(),
        ),
        // عرض النقاط
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
    );
  }
}
