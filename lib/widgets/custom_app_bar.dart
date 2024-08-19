import 'package:taxi_obic/utils/import.dart';

Widget appBarSimple(context,title) {
  return Positioned(
    top: 0,
    left: 0,
    right: 0,
    child: Container(
      decoration: const BoxDecoration(
        color: Color(0xFF252424),
      ),
      child: Container(
        padding: const EdgeInsets.fromLTRB(30, 30, 30, 10),
        child: Row(
          children: [
            Container(
                decoration: BoxDecoration(
                    color: AppColor.primaryColor,
                    borderRadius: BorderRadius.circular(22)
                ),
                child: InkWell(onTap: (){Navigator.pop(context);},child: const Icon(Icons.arrow_circle_left_outlined,color: Colors.black))),
            const SizedBox(width: 8),
            Text(title,style: const TextStyle(color: Colors.white),)
          ],
        ),
      ),
    ),
  );
}
