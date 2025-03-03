import 'package:task1/features/weather/domain/entities/ai_prediction_entity.dart';
import 'package:task1/features/weather/domain/entities/weather_entity.dart';
import 'package:task1/features/weather/domain/repositories/ai_weather_repository.dart';
import 'package:task1/features/weather/data/datasources/ai_model_service.dart';

class AiWeatherRepositoryImpl implements AiWeatherRepository {
  final AiModelService aiModelService;

  AiWeatherRepositoryImpl({required this.aiModelService});

  @override
  Future<AiPredictionEntity> predictOutdoorActivity(
      WeatherEntity weatherData) async {
    // Process the weather data into the format required by the AI model
    final List<int> processedData = _processWeatherData(weatherData);

    // Get prediction from the AI model service
    return await aiModelService.predict(processedData);
  }

  // Helper method to process weather data into the required binary format
  List<int> _processWeatherData(WeatherEntity weatherData) {
    // Convert weather data to the 5 binary inputs required by the model

    // 1. outlook is rainy (1 if rainy, 0 if not)
    int isRainy = weatherData.isRainy ? 1 : 0;

    // 2. outlook is sunny (1 if sunny, 0 if not)
    // We'll consider it sunny if it's not cloudy and not rainy
    int isSunny = (!weatherData.isCloudy && !weatherData.isRainy) ? 1 : 0;

    // 3. temperature is hot (1 if hot, 0 if not)
    // Consider hot if temperature is above 28°C
    int isHot = (weatherData.currentTemp > 28.0) ? 1 : 0;

    // 4. temperature is mild (1 if mild, 0 if not)
    // Consider mild if temperature is between 18°C and 28°C
    int isMild =
        (weatherData.currentTemp >= 18.0 && weatherData.currentTemp <= 28.0)
            ? 1
            : 0;

    // 5. humidity is normal (1 if normal, 0 if not)
    // Consider normal humidity between 30% and 60%
    int isHumidityNormal =
        (weatherData.humidity >= 30.0 && weatherData.humidity <= 60.0) ? 1 : 0;

    return [isRainy, isSunny, isHot, isMild, isHumidityNormal];
  }
}
