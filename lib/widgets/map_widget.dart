import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:helpkiosk_frontend/controllers/locations_controller.dart';
import 'package:helpkiosk_frontend/services/location_service.dart';
import 'package:helpkiosk_frontend/models/locations.dart';

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
    locationsController.onMarkerTap = handleMarkerTap;
  }

  void handleMarkerTap(Location location) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 120,
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(location.resourceName,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              TextButton(
                child: Text("Get Directions"),
                onPressed: () async {
                  // Create an instance of LocationService or obtain it from LocationsController
                  LocationService locationService = LocationService();

                  try {
                    LatLng currentLocation =
                        await locationService.getCurrentLocation();
                    LatLng destinationLocation =
                        LatLng(location.latitude, location.longitude);

                    // Call getDirections with currentLocation and destinationLocation
                    await locationService.getDirections(
                        currentLocation, destinationLocation);

                    // Handle the directions data as needed
                    Navigator.pop(context); // Close the bottom sheet
                  } catch (error) {
                    // Handle any errors, such as location service disabled or permissions denied
                    print("Error getting directions: $error");
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (locationsController.location.isNotEmpty) {
        return Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(locationsController.location.first.latitude,
                    locationsController.location.first.longitude),
                zoom: 13,
              ),
              markers: locationsController.filteredMarkers.toSet(),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                // Set the corners as rounded
                color: Colors.transparent,
                border: Border.all(
                  color: Colors.white, // Set border color
                  width: 5.0, // Set border width
                ),
              ),
            ),
          ],
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
