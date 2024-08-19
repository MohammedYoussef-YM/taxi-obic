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
              create: (_) => OnBoardingViewModel(),
              child: Column(
                children: [
                  Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          const Spacer(flex: 1),
                          const CustomRow(name: "obic ", title: "taxi", mainAxisAlignment: MainAxisAlignment.center, fontSize: 34,),
                          const Spacer(flex: 1),
                          const SizedBox(width:200,height:200,child: Image(image: AssetImage(AppImageAsset.map))),
                          const Spacer(flex: 1),
                          CustomButtonGeneral(title: 'Get Started', isRegisterButton: false, onPressed: () {
                            Navigator.pushReplacementNamed(context, '/login');
                          },),
                          CustomButtonGeneral(title: 'Registration', isRegisterButton: true, onPressed: () {
                            Navigator.pushReplacementNamed(context, '/login');
                          },),
                          const Spacer(flex: 1),
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
