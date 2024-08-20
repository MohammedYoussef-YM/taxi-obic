import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:taxi_obic/models/truck.dart';
import 'package:taxi_obic/services/shared_preferences_service.dart';

import '../models/price.dart';
import '../models/taxi.dart';

class ApiService {
  final String _baseUrl = 'http://192.168.1.104:5004';
  final SharedPreferencesService _prefsService;

  ApiService(this._prefsService);

  Future<String> login(String phoneNumber) async {
    final url = Uri.parse('$_baseUrl/auth/api/token/');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'phone': phoneNumber, 'password': "123"}),
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final String accessToken = jsonResponse['access'];

      await _prefsService.saveCredentials(accessToken, phoneNumber);
      return accessToken;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<Taxi>> fetchNearestTaxis(double latitude, double longitude, double radius, String token) async {
    final String url = '$_baseUrl/api/taxis/find_nearest_taxis/?lat=$latitude&long=$longitude&radius=$radius';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token', // Add the token here
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((taxi) => Taxi.fromJson(taxi)).toList(); // Assuming Taxi has a fromJson method
      } else {
        throw Exception('Failed to load taxis');
      }
    } catch (e) {
      print('Error fetching taxis: $e');
      return []; // Return an empty list on error
    }
  }
  Future<List<Truck>> fetchNearestTruck(double latitude, double longitude, double radius, String token) async {
    print('-------f-f-f');
    final String url = '$_baseUrl/api/trucks/find_nearest_trucks/?lat=$latitude&long=$longitude&radius=$radius';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token', // Add the token here
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((truck) => Truck.fromJson(truck)).toList(); // Assuming Taxi has a fromJson method
      } else {
        throw Exception('Failed to load taxis');
      }
    } catch (e) {
      print('Error fetching taxis: $e');
      return []; // Return an empty list on error
    }
  }
  Future<Map<String, String?>> getStoredCredentials() async {
    return await _prefsService.getCredentials();
  }

  Future<void> clearStoredCredentials() async {
    await _prefsService.clearCredentials();
  }

  Future<Price> getPrice({
    required double startLat,
    required double startLong,
    required double endLat,
    required double endLong,
    required String token,
    required int taxiId,
  }) async {
    final url = Uri.parse(
      '$_baseUrl/api/bookings/calculate_price/'
          '?start_lat=$startLat&start_long=$startLong&end_lat=$endLat&end_long=$endLong&taxi_id=$taxiId',
    );

    try {
      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        return Price.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load price: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error fetching price: $e');
      throw Exception('Error fetching price');
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
      final url = Uri.parse('$_baseUrl/api/taxis/book_taxi/');
      var body = {
        "taxi_id": taxiId,
        "current_lat": startLat.toString(),
        "current_long": startLong.toString(),
        "dest_lat": endLat.toString(),
        "dest_long": endLong.toString(),
      };
      final response = await http.post(
        url,
        body: body,
        headers: {'Authorization': 'Bearer $token'},
      );

      print('response.statusCode');
      print(response.statusCode);
      print(response.statusCode.runtimeType);
      print('response.statusCode');

      if (response.statusCode == 200) {
        return 200;
        // Booking successful, proceed to the next step
      } else {
        // Handle error (e.g., show a message to the user)
        return 0;
      }
    } catch (e) {
      // Handle the exception
      print('e');
      print(e);
      print('e');
      return 0;
      print('Error booking taxi: $e');
    }
  }

  Future<int> bookTruck({
    required double startLat,
    required double startLong,
    required double endLat,
    required double endLong,
    required String token,
    required String truckId,
  }) async {
    try {
      final url = Uri.parse('$_baseUrl/api/trucks/book_truck/');
      var body = {
        "truck_id": truckId,
        "current_lat": startLat.toString(),
        "current_long": startLong.toString(),
        "dest_lat": endLat.toString(),
        "dest_long": endLong.toString(),
      };
      final response = await http.post(
        url,
        body: body,
        headers: {'Authorization': 'Bearer $token'},
      );

      print('response.statusCode');
      print(response.statusCode);
      print(response.statusCode.runtimeType);
      print('response.statusCode');

      if (response.statusCode == 200) {
        return 200;
        // Booking successful, proceed to the next step
      } else {
        // Handle error (e.g., show a message to the user)
        return 0;
      }
    } catch (e) {
      // Handle the exception
      print('e');
      print(e);
      print('e');
      return 0;
      print('Error booking taxi: $e');
    }
  }


}