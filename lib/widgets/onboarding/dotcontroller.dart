import 'package:taxi_obic/utils/import.dart';

class CustomDotControllerOnBoarding extends StatelessWidget {
  const CustomDotControllerOnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<OnBoardingViewModel>(
      builder: (context, controller, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            ...List.generate(
              onBoardingList.length,
                  (index) => AnimatedContainer(
                margin: const EdgeInsets.only(right: 5),
                duration: const Duration(milliseconds: 900),
                width: controller.currentPage == index ? 15 : 15,
                height: 15,
                decoration: BoxDecoration(
                  color: controller.currentPage == index ? AppColor.primaryColor : AppColor.white,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
