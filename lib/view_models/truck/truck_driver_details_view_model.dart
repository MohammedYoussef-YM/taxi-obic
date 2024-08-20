import 'package:taxi_obic/utils/import.dart';

class TruckDriverDetailsViewModel extends ChangeNotifier {
  final Completer<GoogleMapController> mapController = Completer();
  Set<Marker> markers = {};
  GoogleMapController? controller;


  final CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(15.371921, 44.195652),
    zoom: 14.4746,
  );

  void goToConfirmTruckBook(context,truck) {
    Navigator.pushReplacementNamed(context, '/confirmTruckBook',arguments: truck);
  }

  void specificMarkers(context,truck) async {

    markers.clear();

    // Load custom icons
    final availableIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(18, 18)),
      'assets/images/truck_c.png',
    );

    final unavailableIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(18, 18)),
      'assets/images/truck_c.png', // Use a different icon for unavailable taxis
    );

    print('truck');
    print(truck.id);
    print(truck.latitude);
    print('truck');

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