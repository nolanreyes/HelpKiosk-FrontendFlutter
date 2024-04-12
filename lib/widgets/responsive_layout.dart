import 'package:flutter/material.dart';
import 'package:helpkiosk_frontend/widgets/map_widget.dart';
import 'package:helpkiosk_frontend/widgets/resource_selector.dart';
import 'package:helpkiosk_frontend/widgets/balance_display.dart';
import 'package:helpkiosk_frontend/widgets/weather_widget.dart';
import 'package:helpkiosk_frontend/widgets/chatbot_widget.dart';

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
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                flex: 4,
                                child: MapWidget(),
                              ),
                              Expanded(
                                flex: 1,
                                child:
                                    ChatBotWidget(), // Add ChatBotWidget here
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex:
                              1, // 1 part of the screen for the resource selector
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                flex: 4,
                                child: ResourceSelector(),
                              ),
                              Expanded(
                                flex: 1,
                                child: BalanceDisplay(),
                              ),
                            ],
                          ),
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
                    child: MapWidget(),
                  ),
                  Container(
                    height: 100,
                    // Set a fixed height for the ResourceSelector
                    width: double.infinity,
                    // Make it take up the full width of the screen
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        ResourceSelector(),
                      ],
                    ),
                  ),
                ],
              ));
  }
}
