// domain/usecases/get_weather.dart

import 'package:task1/features/weather/domain/entities/weather_entity.dart';
import 'package:task1/features/weather/domain/repositories/weather_repository.dart';

class GetWeatherUseCase {
  final WeatherRepository repository;

  GetWeatherUseCase({required this.repository});

  Future<WeatherEntity> execute(double lat, double lon) async {
    return await repository.getWeather(lat, lon);
  }
}
