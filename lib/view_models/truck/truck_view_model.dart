import 'package:taxi_obic/utils/import.dart';

class TruckViewModel extends ChangeNotifier {

  final ApiService _apiService;
  final SharedPreferencesService _sharedPreferencesService;
  LatLng? currentLocation;
  final Completer<GoogleMapController> mapController = Completer();
  GoogleMapController? controller;
  List<Truck> trucks = [];
  Set<Marker> markers = {};

  TruckViewModel(this._apiService, this._sharedPreferencesService);

  Future<void> getCurrentLocation(BuildContext context) async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      currentLocation = LatLng(position.latitude, position.longitude);
      notifyListeners();

      // Move the camera to the current location
      if (controller != null) {
        controller!.animateCamera(CameraUpdate.newLatLng(currentLocation!));
        await fetchTrucks(context); // Fetch taxis after getting location
      }
    } catch (e) {
      // Handle location permission denied or other errors
      showErrorDialog(context, 'Unable to fetch location: $e');
    }
  }

  Future<void> fetchTrucks(BuildContext context) async {
    if (currentLocation != null) {
      final credentials = await _sharedPreferencesService.getCredentials();
      final token = credentials['accessToken'];

      // Fetch taxis using the token
      trucks = await _apiService.fetchNearestTruck(
        currentLocation!.latitude,
        currentLocation!.longitude,
        2,
        token ?? '',
      );

      updateTruckMarkers(context);
      notifyListeners();
    }
  }

  void updateTruckMarkers(BuildContext context) async {
    markers.clear();

    // Load custom icons
    final availableIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(18, 18)),
      'assets/images/truck_c.png',
    );

    final unavailableIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(18, 18)),
      'assets/images/truck_c.png', // Ensure you have a different icon for unavailable taxis
    );

    for (var truck in trucks) {
      markers.add(
        Marker(
          markerId: MarkerId('${truck.id}'),
          position: LatLng(truck.latitude!, truck.longitude!),
          icon: truck.available! ? availableIcon : unavailableIcon,
          onTap: () => _showTaxiInfoDialog(context,truck),
        ),
      );
    }
  }

  void _showTaxiInfoDialog(BuildContext context,truck) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Driver: ${truck.driverName}\nType: ${truck.type}',
            style: const TextStyle(fontSize: 14),
            textAlign: TextAlign.center,
          ),
          content: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xffF3A205),
            ),
            onPressed: () {
              goToTruckRent(context, truck);
              Navigator.pop(context);
            },
            child: const Text('Book',style: TextStyle(
                color: AppColor.blackButton,
                fontWeight: FontWeight.bold,
                fontSize: 16
            ),),
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

  void goToTruckDetails(context) {
    Navigator.pushReplacementNamed(context, '/truckDriverDetails');
  }

}
