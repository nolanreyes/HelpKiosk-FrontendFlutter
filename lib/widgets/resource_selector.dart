import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpkiosk_frontend/controllers/locations_controller.dart';
import 'package:helpkiosk_frontend/widgets/resource_button.dart';

class ResourceSelector extends StatelessWidget {
  final LocationsController locationsController =
      Get.find<LocationsController>();

  @override
  Widget build(BuildContext context) {
    bool isLargeScreen = MediaQuery.of(context).size.width > 768;

    List<Widget> buttons = [
      ResourceButton(
          icon: Icons.view_list,
          label: 'All',
          onTap: () => locationsController.applyFilter('')),
      ResourceButton(
          icon: Icons.local_hotel,
          label: 'Shelter',
          onTap: () => locationsController.applyFilter('SHELTER')),
      ResourceButton(
          icon: Icons.restaurant,
          label: 'Food',
          onTap: () => locationsController.applyFilter('FOOD')),
      ResourceButton(
          icon: Icons.local_hospital,
          label: 'Health',
          onTap: () => locationsController.applyFilter('HEALTH')),
      ResourceButton(
          icon: Icons.shower,
          label: 'Hygiene',
          onTap: () => locationsController.applyFilter('HYGIENE')),
      ResourceButton(
          icon: Icons.gavel,
          label: 'Legal',
          onTap: () => locationsController.applyFilter('LEGAL')),
      ResourceButton(
          icon: Icons.wifi,
          label: 'WiFi',
          onTap: () => locationsController.applyFilter('WIFI')),
    ];

    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
      padding: EdgeInsets.all(8),
      child: isLargeScreen
          ? GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 50,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: buttons)
          : Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.spaceEvenly,
              children: buttons),
    );
  }
}
