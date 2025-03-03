import 'package:flutter/material.dart';
import 'package:task1/features/weather/domain/entities/weather_entity.dart';

class WeatherInfoCard extends StatelessWidget {
  final WeatherEntity weather;

  const WeatherInfoCard({Key? key, required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Temperature: ${weather.currentTemp}°C'),
            Text('Cloudy: ${weather.isCloudy ? "Yes" : "No"}'),
            Text('Rainy: ${weather.isRainy ? "Yes" : "No"}'),
            Text('Humidity: ${weather.humidity}%'),
          ],
        ),
      ),
    );
  }
}
