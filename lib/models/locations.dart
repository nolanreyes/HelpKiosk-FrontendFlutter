class Location {
  final int id;
  final String resourceName;
  final double latitude;
  final double longitude;
  final String locationType;
  final String address;
  final String description;
  final String hours;

  Location({
    required this.id,
    required this.resourceName,
    required this.latitude,
    required this.longitude,
    required this.locationType,
    required this.address,
    required this.description,
    required this.hours,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'],
      resourceName: json['resource_name'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      locationType: json['location_type'],
      address: json['address'],
      description: json['description'],
      hours: json['hours'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'resource_name': resourceName,
      'latitude': latitude,
      'longitude': longitude,
      'location_type': locationType,
      'address': address,
      'description': description,
      'hours': hours,
    };
  }
}
