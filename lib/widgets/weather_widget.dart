import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpkiosk_frontend/controllers/weather_controller.dart';

class WeatherDisplay extends StatelessWidget {
  final WeatherController weatherController = Get.find();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Call the fetchWeatherData function when the FutureBuilder is initialized
      future: weatherController.fetchWeatherData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading indicator while waiting for data
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // Handle errors if there are any
          return Text('Error: ${snapshot.error}');
        } else {
          // Display weather data when available
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Temperature: ${weatherController.temperature.value}°C'),
              Text('${weatherController.description.value}'),
            ],
          );
        }
      },
    );
  }
}
