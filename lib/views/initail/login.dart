import 'package:taxi_obic/utils/import.dart';
import 'package:taxi_obic/utils/validinput.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.contain, image: AssetImage(AppImageAsset.taxi))),
          child: Container(
            decoration: const BoxDecoration(color: Color(0xE3000000)),
            child: Consumer<LoginViewModel>(builder: (context, viewModel, child) {
              return Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: Form(
                      key: viewModel.formState,
                      child: Column(
                        children: [
                          const Spacer(flex: 1),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Welcome to ",
                                style: TextStyle(
                                    fontSize: 34,
                                    color: AppColor.primaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text("Obic taxi",
                                  style: TextStyle(
                                      fontSize: 34,
                                      color: AppColor.white,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const Spacer(flex: 1),
                          Consumer<LoginViewModel>(
                              builder: (context, controller, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                inputDecorationTheme: InputDecorationTheme(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: AppColor.backGroundColor),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: AppColor.grey),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 20),
                                child: Consumer<ValidationProvider>(
                                    builder: (context, validationProvider, child) {
                                    return IntlPhoneField(
                                      dropdownIcon: const Icon(Icons.arrow_drop_down, color: AppColor.white),
                                      style: const TextStyle(color: AppColor.white),
                                      dropdownTextStyle: const TextStyle(color: AppColor.white),
                                      controller: controller.phoneController,
                                      keyboardType: TextInputType.phone,
                                      validator: (val) {
                                        return validationProvider.validInput(val!.number, 7, 15, 'phone');
                                      },
                                      decoration:  InputDecoration(
                                        contentPadding: const EdgeInsets.symmetric(
                                            vertical: 1, horizontal: 20),
                                        errorText: validationProvider.errorMessage, // عرض رسالة الخطأ هنا
                                      ),
                                      languageCode: "en",
                                      initialCountryCode: 'YE',
                                      onChanged: (phone) {},
                                    );
                                  }
                                ),
                              ),
                            );
                          }),
                          const Spacer(flex: 1),
                        ],
                      ),
                    ),
                  ),
                  CustomButton(
                    function: () {
                      if (viewModel.formState.currentState!.validate()) {
                        viewModel.login(context);
                      }
                    }
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
