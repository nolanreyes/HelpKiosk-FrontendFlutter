import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpkiosk_frontend/controllers/locations_controller.dart';
import 'package:helpkiosk_frontend/widgets/responsive_layout.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final LocationsController locationsController =
      Get.put(LocationsController());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HELP Kiosk',
      home: Scaffold(
        appBar: AppBar(
          title: Text('H E L P  A P P'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.wb_sunny), // Placeholder for weather info
              onPressed: () {},
            ),
          ],
        ),
        body: SafeArea(
          child: ResponsiveLayout(),
        ),
      ),
    );
  }
}
