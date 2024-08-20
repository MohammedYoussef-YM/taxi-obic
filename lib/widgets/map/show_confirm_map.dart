import 'package:taxi_obic/utils/import.dart';

class ShowConfirmMap extends StatelessWidget {
  const ShowConfirmMap({
    super.key,
    required this.viewModel,
  });

  final dynamic viewModel;

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: viewModel.kGooglePlex,
      onMapCreated: (GoogleMapController controller) {
        viewModel.controllerMap.complete(controller);
      },
      onCameraMove: (CameraPosition position) {
        viewModel.updateLocationFromMap(position);
      },
    );
  }
}
