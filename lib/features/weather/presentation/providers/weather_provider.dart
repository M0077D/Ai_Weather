import 'package:flutter/material.dart';
import 'package:task1/features/weather/domain/entities/weather_entity.dart';
import 'package:task1/features/weather/domain/usecases/get_weather_usecase.dart';

class WeatherProvider with ChangeNotifier {
  WeatherEntity? _weather;
  bool _isLoading = false;

  WeatherEntity? get weather => _weather;
  bool get isLoading => _isLoading;

  final GetWeatherUseCase getWeatherUseCase;

  WeatherProvider({required this.getWeatherUseCase});

  Future<void> fetchWeather(double lat, double lon) async {
    _isLoading = true;
    notifyListeners();

    _weather = await getWeatherUseCase.execute(lat, lon);

    _isLoading = false;
    notifyListeners();
  }
}
