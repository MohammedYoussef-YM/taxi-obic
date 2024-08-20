import 'package:taxi_obic/utils/import.dart';

class ShowMap extends StatelessWidget {
  const ShowMap({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const GoogleMap(
      myLocationEnabled: true,
      trafficEnabled: true,
      initialCameraPosition: CameraPosition(
        target: LatLng(15.371921, 44.195652), // Default location
        zoom: 14.4746,
      ),
    );
  }
}