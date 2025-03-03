class WeatherEntity {
  final double currentTemp;
  final bool isCloudy;
  final bool isRainy;
  final double humidity;
  final List<DailyWeatherEntity> dailyWeather;

  WeatherEntity({
    required this.currentTemp,
    required this.isCloudy,
    required this.isRainy,
    required this.humidity,
    required this.dailyWeather,
  });
}

class DailyWeatherEntity {
  final String date;
  final double avgTemp;
  final bool isCloudy;
  final bool isRainy;
  final double humidity;

  DailyWeatherEntity({
    required this.date,
    required this.avgTemp,
    required this.isCloudy,
    required this.isRainy,
    required this.humidity,
  });
}

// class AiWeatherEntity {
//   final double currentTemp;
//   final bool isCloudy;
//   final bool isRainy;
//   final double humidity;
//   final List<DailyWeatherEntity> AiWeatherlist;
//   AiWeatherEntity({
//     required this.currentTemp,
//     required this.isCloudy,
//     required this.isRainy,
//     required this.humidity,
//     required this.AiWeatherlist,
//   });
// }

class PredictionResult {
  final bool willGoOutside;

  PredictionResult({required this.willGoOutside});
}
