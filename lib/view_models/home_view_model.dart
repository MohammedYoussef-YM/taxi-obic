import 'package:taxi_obic/utils/import.dart';

class HomeViewModel extends ChangeNotifier {
  final ApiService _apiService;
  final SharedPreferencesService _sharedPreferencesService;
  LatLng? currentLocation;
  final Completer<GoogleMapController> mapController = Completer();
  GoogleMapController? controller;
  List<Taxi> taxis = [];
  Set<Marker> markers = {};

  HomeViewModel(this._apiService, this._sharedPreferencesService);

  Future<void> getCurrentLocation(BuildContext context) async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      currentLocation = LatLng(position.latitude, position.longitude);
      notifyListeners();

      // Move the camera to the current location
      if (controller != null) {
        controller!.animateCamera(CameraUpdate.newLatLng(currentLocation!));
        await fetchTaxis(context); // Fetch taxis after getting location
      }
    } catch (e) {
      // Handle location permission denied or other errors
      showErrorDialog(context, 'Unable to fetch location: $e');
    }
  }

  Future<void> fetchTaxis(BuildContext context) async {
    if (currentLocation != null) {
      final credentials = await _sharedPreferencesService.getCredentials();
      final token = credentials['accessToken'];

      // Fetch taxis using the token
      taxis = await _apiService.fetchNearestTaxis(
        currentLocation!.latitude,
        currentLocation!.longitude,
        2,
        token ?? '',
      );

      updateTaxiMarkers(context);
      notifyListeners();
    }
  }

  void updateTaxiMarkers(BuildContext context) async {
    markers.clear();

    // Load custom icons
    final availableIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(18, 18)),
      'assets/images/taxi_marker.png',
    );

    final unavailableIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(18, 18)),
      'assets/images/taxi_marker_unavailable.png', // Ensure you have a different icon for unavailable taxis
    );

    for (var taxi in taxis) {
      markers.add(
        Marker(
          markerId: MarkerId('${taxi.id}'),
          position: LatLng(taxi.latitude, taxi.longitude),
          icon: taxi.available ? availableIcon : unavailableIcon,
          onTap: () => _showTaxiInfoDialog(context,taxi),
        ),
      );
    }
  }

  void _showTaxiInfoDialog(BuildContext context,taxi) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            children: [
              Text(
                'Driver: ${taxi.driverName}\nType: ${taxi.type}',
                style: const TextStyle(fontSize: 14),
                textAlign: TextAlign.start,
              ),
            ],
          ),
          content: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xffF3A205),
            ),
            onPressed: () {
              goToTaxiRent(context, taxi);
            },
            child:  const Text('Book',style:  TextStyle(
                color: Colors.black,
                fontSize: 18)),
          ),
        );
      },
    );
  }

  void goToTaxiRent(context, taxi) {
    // Update the driverPoint and taxi in DriverDetailsViewMode// Use the correct method name
    Navigator.pushNamed(context, '/taxiDriverDetails',arguments: taxi);
  }

  void goToTruckRent(context, truck) {
    // Update the driverPoint and taxi in DriverDetailsViewMode// Use the correct method name
    Navigator.pushNamed(context, '/truckDriverDetails',arguments: truck);
  }

  void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}