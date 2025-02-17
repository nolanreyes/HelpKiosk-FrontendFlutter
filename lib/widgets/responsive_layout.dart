import 'package:flutter/material.dart';
import 'package:helpkiosk_frontend/widgets/map_widget.dart';
import 'package:helpkiosk_frontend/widgets/resource_selector.dart';
import 'package:helpkiosk_frontend/widgets/balance_display.dart';
import 'package:helpkiosk_frontend/widgets/weather_widget.dart';
import 'package:helpkiosk_frontend/widgets/chatbot_widget.dart';

class ResponsiveLayout extends StatefulWidget {
  @override
  _ResponsiveLayoutState createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  Key key = UniqueKey();

  // Reload button for  demo
  void reloadPage() {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (BuildContext context) => super.widget,
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    bool isLargeScreen = MediaQuery.of(context).size.width > 768;

    return Scaffold(
      appBar: AppBar(
        title: Text('H E L P  A P P'),
        centerTitle: false,
      ),
      body: Container(
        color: Colors.grey[200],
        child: isLargeScreen
            ? Column(
                children: <Widget>[
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: Column(
                            children: <Widget>[
                              // Widgets for the left section of the interface
                              Expanded(
                                flex: 4,
                                child: _roundedContainer(MapWidget()),
                              ),
                              Expanded(
                                flex: 1,
                                child: _roundedContainer(ChatBotWidget()),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: <Widget>[
                              // Widgets for the right section of the interface
                              Expanded(
                                flex: 4,
                                child: _roundedContainer(ResourceSelector()),
                              ),
                              Expanded(
                                flex: 1,
                                child: _roundedContainer(BalanceDisplay()),
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
                  Expanded(
                    child: _roundedContainer(MapWidget()),
                  ),
                  Container(
                    height: 120,
                    width: double.infinity,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        _roundedContainer(ResourceSelector()),
                      ],
                    ),
                  ),
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: reloadPage,
        child: Icon(Icons.refresh),
      ),
    );
  }

  Widget _roundedContainer(Widget child) {
    return Container(
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.grey[200],
      ),
      child: child,
    );
  }
}
