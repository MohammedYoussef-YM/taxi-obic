import 'package:taxi_obic/utils/import.dart';

class ButtonBook extends StatelessWidget {
  final String title; // Define a parameter to accept the title
  final void Function()? onPressed; // Define a parameter to accept the title
  final bool? isDone; // Define a parameter to accept the title
  const ButtonBook({
    super.key,
    required this.title,
    required this.onPressed,
    required this.isDone,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: isDone == true ? const Color(0xFF252424) : const Color(0xFF53504D),
        boxShadow: [
          BoxShadow(
            color: isDone == true ? const Color(0x40A9A6A6):const Color(0x40000000),
            offset: const Offset(0, 4),
            blurRadius: 2,
          ),
        ],
      ),
      child: Container(
        width: 277,
        padding: const EdgeInsets.fromLTRB(2.2, 4, 0, 5),
        child: InkWell(
          onTap: onPressed,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 22,
                color: isDone == true? const Color(0xFFffffff) : const Color(0xFFF3A205)),
          ), // يتم استخدام العنوان الممرر هنا
        ),
      ),
    );
  }
}
