import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:helpkiosk_frontend/controllers/locations_controller.dart';

class MapContent extends StatefulWidget {
  @override
  _MapContentState createState() => _MapContentState();
}

class _MapContentState extends State<MapContent> {
  LocationsController locationsController = Get.put(LocationsController());

  @override
  void initState() {
    super.initState();
    locationsController.fetchLocations();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (locationsController.location.isNotEmpty) {
        return GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(locationsController.location.first.latitude,
                locationsController.location.first.longitude),
            zoom: 13,
          ),
          markers: locationsController.filteredMarkers.toSet(),
        );
      } else {
        return Center(child: CircularProgressIndicator());
      }
    });
  }
}

class MapWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MapContent(); // Use the refactored map content widget
  }
}
