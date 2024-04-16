import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:helpkiosk_frontend/controllers/locations_controller.dart';
import 'package:helpkiosk_frontend/services/location_service.dart';
import 'package:helpkiosk_frontend/models/locations.dart';
import 'package:helpkiosk_frontend/constants.dart';
import 'package:http/http.dart' as http;

// Widget for displaying the map content
class MapContent extends StatefulWidget {
  @override
  _MapContentState createState() => _MapContentState();
}

class _MapContentState extends State<MapContent> {
  // Initialize the locations controller
  LocationsController locationsController = Get.put(LocationsController());

  String message = '';

  @override
  void initState() {
    super.initState();
    // Fetch locations and set the marker tap handler on initialization
    locationsController.fetchLocations();
    locationsController.onMarkerTap = handleMarkerTap;
  }

  // Handler for when a marker is tapped
  void handleMarkerTap(Location location) {
    // Show a dialog with location details and a button for getting directions
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Dialog(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width * 0.5,
                child: Padding(
                  padding: const EdgeInsets.all(16.0), // Add padding here
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // Center the children vertically
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // Center the children horizontally
                    children: <Widget>[
                      Text(location.resourceName,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Location Type: ${location.locationType}'),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Address: ${location.address}'),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Description: ${location.description}'),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Hours: ${location.hours}'),
                      ),
                      SizedBox(height: 10),
                      TextButton(
                        child: Text("Get Directions"),
                        onPressed: () async {
                          // implement code for directions
                        },
                      ),
                      // Check if the location is a shelter
                      if (location.locationType == 'SHELTER')
                        TextButton(
                          child: Text("Book Accommodation"),
                          onPressed: () {
                            allocateBedToGuest(setState);
                          },
                        ),
                      Text(message), // Display the message here
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void allocateBedToGuest(StateSetter setState) async {
    final response = await http
        .get(Uri.parse('$apiUrl/sheltermanagement/allocate-bed-flutter/'));
    if (response.statusCode == 200) {
      setState(() {
        message = 'Bed allocated successfully';
      });
    } else {
      setState(() {
        message = 'Failed to allocate bed to guest';
      });
    }
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        message = '';
      });
    });
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
