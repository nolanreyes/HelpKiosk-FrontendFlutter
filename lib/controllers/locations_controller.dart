import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:helpkiosk_frontend/models/locations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class LocationsController extends GetxController {
  List<Location> location = <Location>[].obs;
  var markers = RxSet<Marker>();
  var filteredMarkers = RxSet<Marker>();
  var isLoading = false.obs;
  var filterType = ''.obs;

  fetchLocations() async {
    try {
      isLoading(true);
      http.Response response =
          await http.get(Uri.parse('http://127.0.0.1:8000/locations/'));
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        var results = jsonData['results'] as List;
        location.addAll(results.map((e) => Location.fromJson(e)).toList());
        applyFilter(filterType.value);
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
          icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueMagenta),
          position: LatLng(element.latitude, element.longitude),
          infoWindow: InfoWindow(
              title: element.resourceName, snippet: element.locationType),
          onTap: () {
            print('tapped');
          }));
    });
    applyFilter(filterType.value);
  }

  void applyFilter(String type) {
    filterType.value = type;
    filteredMarkers.clear();
    if (type.isEmpty) {
      filteredMarkers.addAll(markers);
    } else {
      // Use the set of location IDs for comparison to avoid null issues
      var locationIdsWithType = location
          .where((loc) => loc.locationType == type)
          .map((loc) => loc.id)
          .toSet();

      filteredMarkers.addAll(markers.where((marker) {
        var locationId = int.tryParse(marker.markerId.value);
        // Check if the locationId is in the set of IDs with the correct type
        return locationId != null && locationIdsWithType.contains(locationId);
      }));
    }
  }
}
