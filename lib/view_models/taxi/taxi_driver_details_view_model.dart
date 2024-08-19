import 'package:taxi_obic/utils/import.dart';

class TaxiDriverDetailsViewModel extends ChangeNotifier {
  final Completer<GoogleMapController> mapController = Completer();
  Set<Marker> taxiMarkers = {};
  GoogleMapController? controller;


  final CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(15.371921, 44.195652),
    zoom: 14.4746,
  );

  void goToConfirmTaxiBook(context,taxi) {
    Navigator.pushReplacementNamed(context, '/confirmTaxiBook',arguments: taxi);
  }

  void specificMarkers(BuildContext context,taxi) async {

    taxiMarkers.clear();

    // Load custom icons
    final availableIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(18, 18)),
      'assets/images/taxi_marker.png',
    );

    final unavailableIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(18, 18)),
      'assets/images/taxi_marker_unavailable.png', // Use a different icon for unavailable taxis
    );

    taxiMarkers.add(
      Marker(
        markerId: MarkerId('${taxi!.id}'),
        position: LatLng(taxi!.latitude, taxi!.longitude),
        icon: taxi!.available ? availableIcon : unavailableIcon,
      ),
    );

    notifyListeners(); // Notify listeners after updating markers
  }
}