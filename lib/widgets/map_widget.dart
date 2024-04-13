import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:helpkiosk_frontend/controllers/locations_controller.dart';
import 'package:helpkiosk_frontend/services/location_service.dart';
import 'package:helpkiosk_frontend/models/locations.dart';

// Widget for displaying the map content
class MapContent extends StatefulWidget {
  @override
  _MapContentState createState() => _MapContentState();
}

class _MapContentState extends State<MapContent> {
  // Initialize the locations controller
  LocationsController locationsController = Get.put(LocationsController());

  @override
  void initState() {
    super.initState();
    // Fetch locations and set the marker tap handler on initialization
    locationsController.fetchLocations();
    locationsController.onMarkerTap = handleMarkerTap;
  }

  // Handler for when a marker is tapped
  void handleMarkerTap(Location location) {
    // Show a bottom sheet with location details and a button for getting directions
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
                  LocationService locationService = LocationService();

                  try {
                    LatLng currentLocation =
                        await locationService.getCurrentLocation();
                    LatLng destinationLocation =
                        LatLng(location.latitude, location.longitude);

                    await locationService.getDirections(
                        currentLocation, destinationLocation);

                    Navigator.pop(context);
                  } catch (error) {
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
    // Use Obx to reactively update the map when the locations change
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
                color: Colors.transparent,
                border: Border.all(
                  color: Colors.white,
                  width: 5.0,
                ),
              ),
            ),
          ],
        );
      } else {
        // Show a loading spinner if the locations are not yet loaded
        return Center(child: CircularProgressIndicator());
      }
    });
  }
}

// Widget for displaying the map
class MapWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MapContent();
  }
}