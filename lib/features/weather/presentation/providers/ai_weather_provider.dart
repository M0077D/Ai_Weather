import 'package:flutter/material.dart';
import 'package:task1/features/weather/domain/entities/ai_prediction_entity.dart';
import 'package:task1/features/weather/domain/entities/weather_entity.dart';
import 'package:task1/features/weather/domain/usecases/predict_outdoor_activity_usecase.dart';

class AiWeatherProvider with ChangeNotifier {
  AiPredictionEntity? _prediction;
  bool _isLoading = false;

  AiPredictionEntity? get prediction => _prediction;
  bool get isLoading => _isLoading;

  final PredictOutdoorActivityUseCase predictOutdoorActivityUseCase;

  AiWeatherProvider({required this.predictOutdoorActivityUseCase});

  Future<void> predictOutdoorActivity(WeatherEntity weatherData) async {
    _isLoading = true;
    notifyListeners();

    try {
      _prediction = await predictOutdoorActivityUseCase.execute(weatherData);
    } catch (e) {
      print('Error making AI prediction: $e');
      // Handle error appropriately
    }

    _isLoading = false;
    notifyListeners();
  }
}
