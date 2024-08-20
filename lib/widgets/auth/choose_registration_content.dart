import 'package:taxi_obic/utils/import.dart';

class ChooseRegistrationContent extends StatelessWidget {
  const ChooseRegistrationContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}