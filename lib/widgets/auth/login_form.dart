import 'package:taxi_obic/utils/import.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {

    return Consumer<LoginViewModel>(
      builder: (context, viewModel, child) {
        return Column(
          children: [
            const Expanded(
              flex: 3,
              child: Column(
                children: [
                  Spacer(flex: 1),
                  WelcomeMessage(),
                  Spacer(flex: 1),
                  PhoneInputField(),
                  Spacer(flex: 1),
                ],
              ),
            ),
            CustomButton(
              function: () {
                viewModel.login(context);
              },
            ),
          ],
        );
      },
    );
  }
}