import 'package:taxi_obic/utils/import.dart';

class CustomTextFieldArrive extends StatelessWidget {
  final String hint; // Define a parameter to accept the title
  final TextEditingController? controller;
  final void Function()? onPressed; // Define a parameter to accept the title
  final IconData? icon; // Define a parameter to accept the title
  const CustomTextFieldArrive({
    super.key, required this.hint,this.controller, this.onPressed,required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 0,horizontal: 12), // Decrease vertical padding
        hintText: hint,
        fillColor: const Color(0xFF252424),
        prefixIcon: Icon(icon, color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),  // تعيين borderRadius هنا
          borderSide: const BorderSide(color: Color(0xFF4A4747),width: 2),
        ),
        enabledBorder:   OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),  // تعيين borderRadius هنا
          borderSide: const BorderSide(color: Color(0xFF4A4747),width: 2),
        ),
        focusedBorder:  OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),  // تعيين borderRadius هنا
          borderSide: const BorderSide(color: Colors.white),
        ),
      ),
      style: const TextStyle(color: Colors.white),
      onTap: onPressed,
    );
  }
}
