import 'package:flutter/material.dart';
import 'package:helpkiosk_frontend/widgets/map_widget.dart';
import 'package:helpkiosk_frontend/widgets/resource_selector.dart';

class ResponsiveLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Determine if we're on a large screen
    bool isLargeScreen = MediaQuery.of(context).size.width > 768;

    return Container(
      color: Colors.grey[200],
      child: isLargeScreen
          ? Row(
              children: <Widget>[
                Expanded(
                  flex: 3, // 3 parts of the screen for the map
                  child: MapWidget(),
                ),
                Expanded(
                  flex: 1, // 1 part of the screen for the resource selector
                  child: ResourceSelector(),
                ),
              ],
            )
          : Column(
              children: <Widget>[
                Expanded(
                  flex: 3, // 3 parts of the screen for the map
                  child: MapWidget(),
                ),
                ResourceSelector(), // No flex, fixed height as needed
              ],
            ),
    );
  }
}
