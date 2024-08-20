import 'dart:ui';
import 'package:taxi_obic/utils/import.dart';

class DriverImage extends StatelessWidget {
  const DriverImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 25,
      bottom: MediaQuery.of(context).size.height * .33,
      child: SizedBox(
        width: 67,
        height: 66,
        child: Stack(
          children: [
            Positioned(
              right: 6,
              bottom: 5,
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 0,
                    sigmaY: 0,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(27.5),
                      color: const Color(0xFF252424),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x40000000),
                          offset: Offset(0, 4),
                          blurRadius: 2,
                        ),
                      ],
                    ),
                    child: const SizedBox(
                      width: 55,
                      height: 55,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 8,
              top: 5,
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppImageAsset.man),
                  ),
                ),
                child: const SizedBox(
                  width: 50,
                  height: 66,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}