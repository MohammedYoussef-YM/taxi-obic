import 'package:taxi_obic/utils/import.dart';

class CustomDotControllerOnBoarding extends StatelessWidget {
  const CustomDotControllerOnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<OnBoardingViewModel>(
      builder: (context, viewModel, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            ...List.generate(
              onBoardingList.length,
                  (index) => AnimatedContainer(
                margin: const EdgeInsets.only(right: 5),
                duration: const Duration(milliseconds: 900),
                width: viewModel.currentPage == index ? 15 : 15,
                height: 15,
                decoration: BoxDecoration(
                  color: viewModel.currentPage == index ? AppColor.primaryColor : AppColor.white,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const Spacer(),
          ],
        );
      },
    );
  }
}
