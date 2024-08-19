import 'package:taxi_obic/utils/import.dart';

Widget appBarWithInfo(context,hint,address,title) {
  return Positioned(
    top: 0,
    left: 0,
    right: 0,
    child: Container(
      decoration: const BoxDecoration(
        color: Color(0xFF252424),
      ),
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 30, 20, 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                    decoration: BoxDecoration(
                        color: AppColor.primaryColor,
                        borderRadius: BorderRadius.circular(22)
                    ),
                    child: InkWell(onTap: (){Navigator.pop(context);},child: const Icon(Icons.arrow_circle_left_outlined,color: Colors.black,size: 30,))),
                const SizedBox(width: 8),
                Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(hint,style: const TextStyle(color: Colors.grey),),
                    const SizedBox(height: 3),
                    Text(address,style: const TextStyle(color: Colors.white),),
                  ],
                )
              ],
            ),
            const SizedBox(height: 20),
            Text(title,style: const TextStyle(color: Colors.white,fontSize: 24))
          ],
        ),
      ),
    ),
  );
}
