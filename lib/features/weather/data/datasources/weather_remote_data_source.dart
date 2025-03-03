import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:task1/core/utities/constants.dart';
import 'package:task1/features/weather/data/models/weather_model.dart';

class WeatherRemoteDataSource {
  Future<WeatherModel> getWeather(double lat, double lon) async {
    final response = await http.get(
      Uri.parse(
          '${AppConstants.weatherBaseUrl}/forecast.json?&q=$lat,$lon&days=3&key=${AppConstants.weatherApiKey}'),
    );

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
