import 'package:task1/features/weather/domain/entities/ai_prediction_entity.dart';
import 'package:task1/features/weather/domain/entities/weather_entity.dart';
import 'package:task1/features/weather/domain/repositories/ai_weather_repository.dart';

class PredictOutdoorActivityUseCase {
  final AiWeatherRepository repository;

  PredictOutdoorActivityUseCase({required this.repository});

  Future<AiPredictionEntity> execute(WeatherEntity weatherData) async {
    return await repository.predictOutdoorActivity(weatherData);
  }
}
