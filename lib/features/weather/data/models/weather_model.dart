class WeatherModel {
  final double currentTemp;
  final bool isCloudy;
  final bool isRainy;
  final double humidity;
  final List<DailyWeather> dailyWeather;

  WeatherModel({
    required this.currentTemp,
    required this.isCloudy,
    required this.isRainy,
    required this.humidity,
    required this.dailyWeather,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final current = json['current'];
    final forecast = json['forecast']['forecastday'];

    return WeatherModel(
      currentTemp: current['temp_c'],
      isCloudy: current['cloud'] > 50,
      isRainy: current['precip_mm'] > 0,
      humidity: current['humidity'].toDouble(),
      dailyWeather: List<DailyWeather>.from(
        forecast.map((day) => DailyWeather.fromJson(day)),
      ),
    );
  }
}

class DailyWeather {
  final String date;
  final double avgTemp;
  final bool isCloudy;
  final bool isRainy;
  final double humidity;

  DailyWeather({
    required this.date,
    required this.avgTemp,
    required this.isCloudy,
    required this.isRainy,
    required this.humidity,
  });

  factory DailyWeather.fromJson(Map<String, dynamic> json) {
    final day = json['day'];
    return DailyWeather(
      date: json['date'],
      avgTemp: day['avgtemp_c'],
      isCloudy: day['avgvis_km'] < 10, // Example condition for cloudy
      isRainy: day['daily_will_it_rain'] == 1,
      humidity: day['avghumidity'].toDouble(),
    );
  }
}
