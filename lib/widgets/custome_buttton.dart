import 'package:taxi_obic/utils/import.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key, required this.function,
  });
  final VoidCallback function;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 3,
        child: Column(
          children: [
            const Spacer(flex: 1),
             CustomButtonGeneral(title: 'Get Started', isRegisterButton: false, onPressed:function
            ),
            const Spacer(flex: 1),
          ],
        ));
  }
}
