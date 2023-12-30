import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:helpkiosk_frontend/models/directions.dart';
//import 'package:helpkiosk_frontend/models/locations.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class LocationService {
  final String key ='AIzaSyBm6quTRYvW39Lb84RSJ4QYtp3z4J26ffs';
  final Location location = Location();

  Future<LatLng> getCurrentLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return Future.error('Location services are disabled.');
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return Future.error('Location permissions are denied');
      }
    }

    _locationData = await location.getLocation();
    return LatLng(_locationData.latitude!, _locationData.longitude!);
  }

  Future<Directions> getDirections(
      LatLng currentLocation, LatLng destinationLocation) async {
    final String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${currentLocation.latitude},${currentLocation.longitude}&destination=${destinationLocation.latitude},${destinationLocation.longitude}&mode=walking&key=$key';

    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var results = {
      'bounds_ne': json['routes'][0]['bounds']['northeast'],
      'bounds_sw': json['routes'][0]['bounds']['southwest'],
      'start_location': json['routes'][0]['legs']['start_location'],
      'end_location': json['routes'][0]['legs']['end_location'],
      'polyline': json['routes'][0]['overview_polyline']['points'],
    };

    // Check if the response contains routes
    if (json['routes'] != null && json['routes'].isNotEmpty) {
      return Directions.fromJson(json);
    } else {
      throw Exception('Failed to retrieve directions');
    }
  }
}
