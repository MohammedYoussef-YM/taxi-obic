import 'package:taxi_obic/utils/import.dart';

Future<void> determinePosition() async {
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
  }

  if (permission == LocationPermission.deniedForever) {
    // Handle the case when permissions are permanently denied
  } else {
    // Permissions are granted, proceed with location fetching
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }
}




class GeolocatorService {
  static Future<LatLng> getCurrentPosition() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied.');
    }

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return LatLng(position.latitude, position.longitude);
  }
}