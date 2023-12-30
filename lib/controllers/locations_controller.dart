import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:helpkiosk_frontend/models/locations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class LocationsController extends GetxController {
  List<Location> location = <Location>[].obs;
  var markers = RxSet<Marker>();
  var isLoading = false.obs;

  fetchLocations() async {
    try {
      isLoading(true);
      http.Response response =
      await http.get(Uri.parse('http://127.0.0.1:8000/locations/'));
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        var results = jsonData['results'] as List;
        location.addAll(results.map((e) => Location.fromJson(e)).toList());
      } else {
        print('Error fetching data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error while getting data: $e');
    } finally {
      isLoading(false);
      createMarkers();
    }
  }

  createMarkers() {
    location.forEach((element) {
      markers.add(Marker(
        markerId: MarkerId(element.id.toString()),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
        position: LatLng(element.latitude, element.longitude),
        infoWindow: InfoWindow(title: element.resourceName, snippet: element.locationType),
        onTap: () {
          print('tapped');
        }
      ));
    });
  }
}
