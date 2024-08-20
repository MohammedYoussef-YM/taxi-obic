import 'package:taxi_obic/utils/import.dart';

class CustomSliderOnBoarding extends StatelessWidget {
  const CustomSliderOnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<OnBoardingViewModel>(
      builder: (context, viewModel, child) {
        return PageView.builder(
          controller: viewModel.pageController,
          onPageChanged: (val) {
            viewModel.onPageChanged(context,val);
          },
          itemCount: onBoardingList.length,
          itemBuilder: (context, i) => SingleChildScrollView(
            child: Column(
              children: [
               SizedBox(height: MediaQuery.of(context).size.height * .1),
                const CustomRow(name: "obic ", title: "taxi", mainAxisAlignment: MainAxisAlignment.center, fontSize: 34,),
                SizedBox(height: MediaQuery.of(context).size.height * .22),
                InkWell(
                  onTap: (){viewModel.next(context);},
                  child: SizedBox(
                    height: 100,
                    child: Stack(
                      children: [
                        Positioned(
                             left: -60,
                             child: Container(
                                 height: 100,
                                 width: 110,
                               decoration: BoxDecoration(
                                 color: AppColor.primaryColor,
                                 borderRadius: BorderRadius.circular(55),
                               ))),
                        Positioned(
                             left: -50,
                             top: 13,
                             child: Container(
                                 height: 75,
                                 width: 90,
                                 decoration: BoxDecoration(
                                   color: AppColor.secondColor,
                                   borderRadius: BorderRadius.circular(45),
                                 ),)),
                        const Positioned(
                            left: 0,
                            top: 35,
                            child: Icon(Icons.arrow_forward,color: AppColor.white,))
                      ],
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .06),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Row(
                    children: [
                      Text(
                        onBoardingList[i].title!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 48,
                          color: AppColor.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30,top: 10),
                  child: Row(
                    children: [
                      Text(
                        onBoardingList[i].body!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                          color: AppColor.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30,top: 10),
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .66,
                        child: Text(
                          onBoardingList[i].desc!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: AppColor.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
