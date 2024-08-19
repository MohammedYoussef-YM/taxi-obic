class Taxi {
  final int id;
  final String name;
  final String color;
  final int capacity;
  final String type;
  final String model;
  final String driverName;
  final double latitude;
  final double longitude;
  final bool available;

  Taxi({
    required this.id,
    required this.name,
    required this.color,
    required this.capacity,
    required this.type,
    required this.model,
    required this.driverName,
    required this.latitude,
    required this.longitude,
    required this.available,
  });

  factory Taxi.fromJson(Map<String, dynamic> json) {
    return Taxi(
      id: json['id'],
      name: json['name'],
      color: json['color'],
      capacity: json['capacity'],
      type: json['type'],
      model: json['model'],
      driverName: json['driver_name'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      available: json['available'],
    );
  }
}