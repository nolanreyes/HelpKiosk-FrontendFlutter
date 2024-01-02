import 'package:flutter/material.dart';
import 'package:helpkiosk_frontend/widgets/map_widget.dart';
import 'package:helpkiosk_frontend/widgets/resource_selector.dart';
import 'weather_widget.dart'; // Import the WeatherDisplay widget

class ResponsiveLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Are we on a large screen?
    bool isLargeScreen = MediaQuery.of(context).size.width > 768;

    return Container(
      color: Colors.grey[200],
      child: isLargeScreen
          ? Column(
              children: <Widget>[
                WeatherDisplay(), // Weather bar at the top
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 3, // 3 parts of the screen for the map
                        child: MapWidget(),
                      ),
                      Expanded(
                        flex:
                            1, // 1 part of the screen for the resource selector
                        child: ResourceSelector(),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : Column(
              children: <Widget>[
                WeatherDisplay(), // Weather bar at the top
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        flex: 3, // 3 parts of the screen for the map
                        child: MapWidget(),
                      ),
                      Expanded(
                        child:
                            ResourceSelector(), // Resource selector takes remaining space
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
