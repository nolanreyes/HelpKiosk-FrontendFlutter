import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpkiosk_frontend/controllers/locations_controller.dart';
import 'package:helpkiosk_frontend/widgets/resource_button.dart';

class ResourceSelector extends StatelessWidget {
  final LocationsController locationsController =
      Get.find<LocationsController>();

  @override
  Widget build(BuildContext context) {
    //Responsive
    bool isLargeScreen = MediaQuery.of(context).size.width > 768;

    List<Widget> buttons = [
      ResourceButton(
        icon: Icons.view_list,
        label: 'All',
        onTap: () => locationsController.applyFilter(''),
      ),
      ResourceButton(
        icon: Icons.local_hotel,
        label: 'Housing',
        onTap: () => locationsController.applyFilter('SHELTER'),
      ),
      ResourceButton(
        icon: Icons.restaurant,
        label: 'Food',
        onTap: () => locationsController.applyFilter('FOOD'),
      ),
      ResourceButton(
        icon: Icons.local_hospital,
        label: 'Health',
        onTap: () => locationsController.applyFilter('HEALTHCARE'),
      ),
      ResourceButton(
        icon: Icons.shower,
        label: 'Hygiene',
        onTap: () => locationsController.applyFilter('HYGIENE'),
      ),
      ResourceButton(
        icon: Icons.gavel,
        label: 'Legal',
        onTap: () => locationsController.applyFilter('LEGAL'),
      ),
      ResourceButton(
        icon: Icons.wifi,
        label: 'WiFi',
        onTap: () => locationsController.applyFilter('WIFI'),
      ),
      Container(),
    ];

    return Container(
      color: Colors.grey[200],
      padding: EdgeInsets.all(8),
      child: isLargeScreen
          ? GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: buttons,
      )
          : Wrap(
        spacing: 8, // Horizontal spacing between buttons
        runSpacing: 8, // Vertical spacing between buttons
        alignment: WrapAlignment.spaceEvenly,
        children: buttons,
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const FilterButton({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(text),
      onPressed: onPressed,
    );
  }
}
