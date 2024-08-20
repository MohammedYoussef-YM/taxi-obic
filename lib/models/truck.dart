class Truck {
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

  Truck(
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

  Truck.fromJson(Map<String, dynamic> json) {
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
