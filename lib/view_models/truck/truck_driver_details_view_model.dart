import 'package:taxi_obic/utils/import.dart';

class TruckDriverDetailsViewModel extends ChangeNotifier {
  final Completer<GoogleMapController> mapController = Completer();
  Set<Marker> markers = {};
  GoogleMapController? controller;


  final CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(15.371921, 44.195652),
    zoom: 14.4746,
  );

  void goToConfirmTruckBook(context) {
    Navigator.pushReplacementNamed(context, '/confirmTruckBook');
  }

  void specificMarkers(BuildContext context,truck) async {

    markers.clear();

    // Load custom icons
    final availableIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(18, 18)),
      'assets/images/taxi_marker.png',
    );

    final unavailableIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(18, 18)),
      'assets/images/taxi_marker_unavailable.png', // Use a different icon for unavailable taxis
    );

    markers.add(
      Marker(
        markerId: MarkerId('${truck!.id}'),
        position: LatLng(truck!.latitude, truck!.longitude),
        icon: truck!.available ? availableIcon : unavailableIcon,
      ),
    );

    notifyListeners(); // Notify listeners after updating markers
  }
}