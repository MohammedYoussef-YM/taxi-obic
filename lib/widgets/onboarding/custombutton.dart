import 'package:taxi_obic/utils/import.dart';

class CustomButtonGeneral extends StatelessWidget {
  final String title;
  final bool isRegisterButton;
  final void Function()? onPressed;

  const CustomButtonGeneral({super.key, required this.title, required this.isRegisterButton, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top:isRegisterButton ? 30 : 0),
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.borderColor,width: 2), // Set the border color here
        borderRadius: BorderRadius.circular(17),
        boxShadow: const [
          BoxShadow(
            color: Color(0x40A9A6A6),
            offset: Offset(0, 4),
            blurRadius: 2,
          ),
        ],
      ),
      height: 35,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(17),
          child: MaterialButton(
            padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 0),
            textColor: isRegisterButton ? AppColor.backGroundColor: AppColor.blackButton,
            onPressed: onPressed,
            color: isRegisterButton ? AppColor.blackButton:AppColor.primaryColor,
            child: Text(title,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),  // يتم استخدام العنوان الممرر هنا
          ),
      ),
    );
  }
}
