import 'package:taxi_obic/utils/import.dart';

class ShowDetailsMap extends StatelessWidget {
  const ShowDetailsMap({
    super.key,
    required this.taxi,
    required this.viewModel,
  });

  final dynamic viewModel,taxi;

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(
        target: LatLng(taxi.latitude, taxi.longitude),
        // Default location
        zoom: 14.4746,
      ),
      onMapCreated: (GoogleMapController controller) {
        viewModel.mapController.complete(controller);
        viewModel.controller = controller;
      },
      markers: viewModel.markers, // Display taxi markers
    );
  }
}
