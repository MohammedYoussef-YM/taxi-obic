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
        'driver_name': taxi.driverName,
        'type': taxi.type,
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
