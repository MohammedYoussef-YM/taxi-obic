class Price {
  double? distanceKm;
  double? price;
  double? travelTimeMinutes;
  List<TaxiData>? taxiData;

  Price({this.distanceKm, this.price, this.travelTimeMinutes, this.taxiData});

  Price.fromJson(Map<String, dynamic> json) {
    distanceKm = json['distance_km'];
    price = json['price'];
    travelTimeMinutes = json['travel_time_minutes'];
    if (json['taxi_data'] != null) {
      taxiData = <TaxiData>[];
      json['taxi_data'].forEach((v) {
        taxiData!.add(new TaxiData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['distance_km'] = this.distanceKm;
    data['price'] = this.price;
    data['travel_time_minutes'] = this.travelTimeMinutes;
    if (this.taxiData != null) {
      data['taxi_data'] = this.taxiData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TaxiData {
  int? id;
  String? name;
  String? color;
  int? capacity;
  String? type;
  String? model;
  String? driverName;
  double? latitude;
  double? longitude;
  bool? available;

  TaxiData(
      {this.id,
        this.name,
        this.color,
        this.capacity,
        this.type,
        this.model,
        this.driverName,
        this.latitude,
        this.longitude,
        this.available});

  TaxiData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    color = json['color'];
    capacity = json['capacity'];
    type = json['type'];
    model = json['model'];
    driverName = json['driver_name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    available = json['available'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['color'] = this.color;
    data['capacity'] = this.capacity;
    data['type'] = this.type;
    data['model'] = this.model;
    data['driver_name'] = this.driverName;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['available'] = this.available;
    return data;
  }
}
