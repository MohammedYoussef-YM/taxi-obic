import 'package:taxi_obic/utils/import.dart';

class CustomRow extends StatelessWidget {
  final String name; // Define a parameter to accept the title
  final String title; // Define a parameter to accept the title
  final double? fontSize; // Define a parameter to accept the title
  final MainAxisAlignment mainAxisAlignment; // Define a parameter to accept the title

  const CustomRow({
    super.key, required this.name, required this.title,required this.fontSize, required this.mainAxisAlignment,
  });

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        Text(
          name,
          style: TextStyle(
              fontSize: fontSize,
              color: AppColor.primaryColor,
              fontWeight: FontWeight.bold),
        ),
        Text(title,
            style: TextStyle(
                fontSize: fontSize,
                color: AppColor.white,
                fontWeight: FontWeight.bold)),
      ],
    );
  }
}
