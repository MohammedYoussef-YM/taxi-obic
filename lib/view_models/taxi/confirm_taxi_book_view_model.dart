import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http; // Import http package for API requests
import 'package:taxi_obic/utils/import.dart';

class ConfirmTaxiBookViewModel extends ChangeNotifier {
  final Completer<GoogleMapController> controllerMap = Completer<GoogleMapController>();
  final SharedPreferencesService _sharedPreferencesService;
  final ApiService _apiService;

  ConfirmTaxiBookViewModel(this._apiService, this._sharedPreferencesService);

  bool isSelectingStartingPoint = true;
  double cost = 15000.0;
  late Taxi taxi;

  TextEditingController startingPointController = TextEditingController();
  TextEditingController arrivalPointController = TextEditingController();

  LatLng? startingPointLatLng;
  LatLng? arrivalPointLatLng;

  Set<Polyline> polylines = {};  // Store the polyline

  void getTaxiData(Taxi theTaxi) {
    taxi = theTaxi;
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
      await _drawRoute();
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
  Future<void> _drawRoute() async {
    if (startingPointLatLng != null && arrivalPointLatLng != null) {
      final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/directions/json'
            '?origin=${startingPointLatLng!.latitude},${startingPointLatLng!.longitude}'
            '&destination=${arrivalPointLatLng!.latitude},${arrivalPointLatLng!.longitude}'
            '&key=AIzaSyCaCSJ0BZItSyXqBv8vpD1N4WBffJeKhLQ',  // Replace YOUR_API_KEY with your actual API key
      );

      try {
        final response = await http.get(url);
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');

        final data = json.decode(response.body);
        print('Decoded data: $data');

        if (data['status'] == 'OK') {
          final routes = data['routes'] as List;
          if (routes.isNotEmpty) {
            final polyline = routes[0]['overview_polyline']['points'];
            final decodedPoints = _decodePolyline(polyline);

            polylines.clear();
            final routePolyline = Polyline(
              polylineId: PolylineId("route"),
              points: decodedPoints,
              color: Colors.blue,
              width: 5,
            );
            polylines.add(routePolyline);

            notifyListeners();
          } else {
            print('No routes found');
          }
        } else {
          print('API Error: ${data['status']}');
          if (data['error_message'] != null) {
            print('Error message: ${data['error_message']}');
          }
        }
      } catch (e) {
        print('Error fetching route: $e');
      }
    }
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
        taxiId: taxi.id,
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
    required String taxiId,
  }) async {
    try {
      var data = await _apiService.book(
        startLat: startLat,
        startLong: startLong,
        endLat: endLat,
        endLong: endLong,
        token: token,
        taxiId: taxiId,
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
      taxiId: '${taxi.id}',
    );

    if (response == 200) {
      Navigator.pushReplacementNamed(context, '/doneBook', arguments: {
        'start': startingPointController.text,
        'arrive': arrivalPointController.text,
        'cost': cost.toStringAsFixed(2),
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
