import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpkiosk_frontend/controllers/locations_controller.dart';
import 'package:helpkiosk_frontend/widgets/responsive_layout.dart';
import 'package:helpkiosk_frontend/donation_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final LocationsController locationsController =
      Get.put(LocationsController());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HELP APP',
      initialRoute: '/',
      routes: {
        '/': (context) => Scaffold(
              backgroundColor: Colors.grey[200], // Set the background color here
              body: SafeArea(
                child: ResponsiveLayout(),
              ),
            ),
        '/donate': (context) => DonationPage(),
      },
    );
  }
}