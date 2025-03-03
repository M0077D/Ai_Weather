import 'package:task1/features/weather/domain/entities/ai_prediction_entity.dart';
import 'package:task1/features/weather/domain/entities/weather_entity.dart';

abstract class AiWeatherRepository {
  Future<AiPredictionEntity> predictOutdoorActivity(WeatherEntity weatherData);
}
