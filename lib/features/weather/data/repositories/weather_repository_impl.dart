import 'package:task1/features/weather/data/datasources/weather_remote_data_source.dart';
import 'package:task1/features/weather/domain/entities/weather_entity.dart';
import 'package:task1/features/weather/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;

  WeatherRepositoryImpl({required this.remoteDataSource});

  @override
  Future<WeatherEntity> getWeather(double lat, double lon) async {
    final weatherModel = await remoteDataSource.getWeather(lat, lon);
    return WeatherEntity(
      currentTemp: weatherModel.currentTemp,
      isCloudy: weatherModel.isCloudy,
      isRainy: weatherModel.isRainy,
      humidity: weatherModel.humidity,
      dailyWeather: weatherModel.dailyWeather
          .map((day) => DailyWeatherEntity(
                date: day.date,
                avgTemp: day.avgTemp,
                isCloudy: day.isCloudy,
                isRainy: day.isRainy,
                humidity: day.humidity,
              ))
          .toList(),
    );
  }
}
