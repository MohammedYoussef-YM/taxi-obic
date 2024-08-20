import 'package:taxi_obic/utils/import.dart';

class WelcomeMessage extends StatelessWidget {
  const WelcomeMessage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Welcome to ",
          style: TextStyle(
              fontSize: 30,
              color: AppColor.primaryColor,
              fontWeight: FontWeight.bold),
        ),
        Text("Obic taxi",
            style: TextStyle(
                fontSize: 30,
                color: AppColor.white,
                fontWeight: FontWeight.bold)),
      ],
    );
  }
}