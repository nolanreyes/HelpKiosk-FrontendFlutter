import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:helpkiosk_frontend/controllers/locations_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HELP Kiosk',
      home: Scaffold(
        appBar: AppBar(
          title: Text('HELP'),
          actions: <Widget>[
            // Weather info here
          ],
        ),
        body: ResponsiveLayout(),
      ),
    );
  }
}

class ResponsiveLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          // Adjust the size as needed
          return Row(
            children: <Widget>[
              Expanded(
                flex: 3,
                child:
                    MapWidget(), // Your Map widget now contains the GoogleMap
              ),
              Expanded(
                flex: 1,
                child: ResourceSelector(), // The resource selection sidebar
              ),
            ],
          );
        } else {
          return Column(
            children: <Widget>[
              Expanded(
                child:
                    MapWidget(), // Your Map widget now contains the GoogleMap
              ),
              ResourceSelector(),
              // The resource selection sidebar moves below the map on smaller screens
            ],
          );
        }
      },
    );
  }
}

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
          markers: locationsController.markers.toSet(),
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

class ResourceSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Replace these Text widgets with your icons/buttons
    return Container(
      color: Colors.grey[200],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Accommodation'),
          Text('Food'),
          // Add other resource selectors here
        ],
      ),
    );
  }
}
