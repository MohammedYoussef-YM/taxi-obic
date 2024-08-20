import 'package:taxi_obic/utils/import.dart';

class PhoneInputField extends StatelessWidget {
  const PhoneInputField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginViewModel>(
        builder: (context, viewModel, child) {
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
              child: IntlPhoneField(
                dropdownIcon: const Icon(Icons.arrow_drop_down, color: AppColor.white),
                style: const TextStyle(color: AppColor.white),
                dropdownTextStyle: const TextStyle(color: AppColor.white),
                controller: viewModel.phoneController,
                keyboardType: TextInputType.phone,
                validator: (val) {
                  // return validationProvider.validInput(val!.number, 7, 15, 'phone');
                },
                decoration:  const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 1, horizontal: 20),
                  // errorText: validationProvider.errorMessage, // عرض رسالة الخطأ هنا
                ),
                languageCode: "en",
                initialCountryCode: 'YE',
              ),
            ),
          );
        });
  }
}
