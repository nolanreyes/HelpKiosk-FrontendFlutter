class Directions {
  final Map<String, double> boundsNE;
  final Map<String, double> boundsSW;
  final Map<String, double> startLocation;
  final Map<String, double> endLocation;
  final String polyline;

  Directions({
    required this.boundsNE,
    required this.boundsSW,
    required this.startLocation,
    required this.endLocation,
    required this.polyline,
  });

  factory Directions.fromJson(Map<String, dynamic> json) {
    return Directions(
      boundsNE: json['routes'][0]['bounds']['northeast'],
      boundsSW: json['routes'][0]['bounds']['southwest'],
      startLocation: json['routes'][0]['legs'][0]['start_location'],
      endLocation: json['routes'][0]['legs'][0]['end_location'],
      polyline: json['routes'][0]['overview_polyline']['points'],
    );
  }
}
