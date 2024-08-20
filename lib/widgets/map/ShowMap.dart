import 'package:taxi_obic/utils/import.dart';

class ShowMap extends StatelessWidget {
  const ShowMap({
    super.key,
    required this.viewModel,
  });

  final dynamic viewModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 66),
      child: GoogleMap(
        myLocationEnabled: true,
        trafficEnabled: true,
        initialCameraPosition: const CameraPosition(
          target: LatLng(15.371921, 44.195652), // Default location
          zoom: 14.4746,
        ),
        onMapCreated: (GoogleMapController controller) {
          viewModel.mapController.complete(controller);
          viewModel.controller = controller;
          viewModel.getCurrentLocation(context);
        },
        markers: viewModel.markers, // Display taxi markers
      ),
    );
  }
}