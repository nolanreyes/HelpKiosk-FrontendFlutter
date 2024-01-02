import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/weather.dart';
import 'dart:developer';

class WeatherController extends GetxController {
  RxDouble temperature = RxDouble(0.0);
  RxString description = RxString('');
  RxInt pressure = RxInt(0);
  RxInt humidity = RxInt(0);
  RxDouble windSpeed = RxDouble(0.0);

  // Fetch weather data from API
  Future<void> fetchWeatherData() async {
    print('fetchWeatherData() called');
    try {
      final response = await http.get(Uri.parse('https://dylannolan.com/api/weather/'));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final weather = Weather.fromJson(jsonData);
        // test to print weather data to the console
        log('Temperature: ${weather.temperature}°C');
        log('Description: ${weather.description}');

        temperature.value = weather.temperature;
        description.value = weather.description;
      } else {
        print('Error fetching weather data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error while fetching weather data: $e');
    }
  }
}
