
import 'dart:async';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import '../../utils/import.dart';

class ConfirmTruckBookViewModel extends ChangeNotifier {
  final Completer<GoogleMapController> controllerMap = Completer<GoogleMapController>();
  final SharedPreferencesService _sharedPreferencesService;
  final ApiService _apiService;

  ConfirmTruckBookViewModel(this._apiService, this._sharedPreferencesService);

  bool isSelectingStartingPoint = true;
  double cost = 15000.0;
  late Truck truck;

  TextEditingController startingPointController = TextEditingController();
  TextEditingController arrivalPointController = TextEditingController();

  LatLng? startingPointLatLng;
  LatLng? arrivalPointLatLng;

  Set<Polyline> polylines = {};  // Store the polyline

  void gettruckData(thetruck) {
    truck = thetruck;
  }

  final CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(15.371921, 44.195652),
    zoom: 14.4746,
  );

  Future<void> updateLocationFromMap(CameraPosition position) async {
    try {
      final credentials = await _sharedPreferencesService.getCredentials();
      final token = credentials['accessToken'];

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.target.latitude,
        position.target.longitude,
      );

      String street = placemarks.isNotEmpty ? placemarks[0].street ?? 'Unknown location' : 'Unknown location';

      if (isSelectingStartingPoint) {
        startingPointController.text = street;
        startingPointLatLng = position.target;
      } else {
        arrivalPointController.text = street;
        arrivalPointLatLng = position.target;
      }
      if (startingPointLatLng != null && arrivalPointLatLng != null) {
        await calculate(
          startingPointLatLng!.latitude,
          startingPointLatLng!.longitude,
          arrivalPointLatLng!.latitude,
          arrivalPointLatLng!.longitude,
          token!,
        );

        // Fetch and draw route
      }
    } catch (e) {
      print("Error in reverse geocoding: $e");
    }

    notifyListeners();
  }

  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> polylinePoints = [];
    int index = 0;
    int len = encoded.length;
    int lat = 0;
    int lng = 0;

    while (index < len) {
      int b;
      int shift = 0;
      int result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lng += dlng;

      final pLat = (lat / 1E5).toDouble();
      final pLng = (lng / 1E5).toDouble();
      polylinePoints.add(LatLng(pLat, pLng));
    }
    return polylinePoints;
  }

  Future<void> calculate(double startLat, double startLong, double endLat, double endLong, String token) async {
    try {
      var data = await _apiService.getPrice(
        startLat: startLat,
        startLong: startLong,
        endLat: endLat,
        endLong: endLong,
        token: token,
        taxiId: truck.id!,
      );

      cost = double.parse((data.price ?? cost).toStringAsFixed(0));
      notifyListeners();
    } catch (e) {
      print("Error in cost calculation: $e");
    }
  }

  Future<int> book({
    required double startLat,
    required double startLong,
    required double endLat,
    required double endLong,
    required String token,
    required String truckId,
  }) async {
    try {
      var data = await _apiService.bookTruck(
        startLat: startLat,
        startLong: startLong,
        endLat: endLat,
        endLong: endLong,
        token: token,
        truckId: truckId,
      );
      return data;
    } catch (e) {
      return 0;
    }
  }

  void goToDoneBook(BuildContext context) async {
    final credentials = await _sharedPreferencesService.getCredentials();
    final token = credentials['accessToken'];

    int response = await book(
      startLat: startingPointLatLng!.latitude,
      startLong: startingPointLatLng!.longitude,
      endLat: arrivalPointLatLng!.latitude,
      endLong: arrivalPointLatLng!.longitude,
      token: token!,
      truckId: '${truck.id}',
    );

    if (response == 200) {
      Navigator.pushReplacementNamed(context, '/doneBook', arguments: {
        'start': startingPointController.text,
        'arrive': arrivalPointController.text,
        'cost': cost.toStringAsFixed(2),
        'driver_name': truck.driverName,
        'type': truck.type,
      });
    } else {
      Fluttertoast.showToast(
        msg: "لم يتم الحجز",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  @override
  void dispose() {
    startingPointController.dispose();
    arrivalPointController.dispose();
    super.dispose();
  }
}
