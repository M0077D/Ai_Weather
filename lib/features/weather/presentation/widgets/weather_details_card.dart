import 'package:flutter/material.dart';
import 'package:task1/features/weather/domain/entities/weather_entity.dart';
import 'package:task1/features/weather/presentation/widgets/weather_detail_item.dart';

class WeatherDetailsCard extends StatelessWidget {
  final DailyWeatherEntity selectedDay;
  final bool isLoadingAI;
  final VoidCallback onRecommendationPressed;

  const WeatherDetailsCard({
    Key? key,
    required this.selectedDay,
    required this.isLoadingAI,
    required this.onRecommendationPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isSmallScreen = constraints.maxWidth < 600;

        return Container(
          padding: EdgeInsets.all(isSmallScreen ? 16 : 24),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withOpacity(0.5),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Weather Details',
                style: TextStyle(
                  fontSize: isSmallScreen ? 20 : 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: isSmallScreen ? 16 : 20),
              WeatherDetailItem(
                label: 'Temperature',
                value: '${selectedDay.avgTemp.toStringAsFixed(1)}°C',
              ),
              WeatherDetailItem(
                label: 'Cloudy',
                value: selectedDay.isCloudy ? "Yes" : "No",
              ),
              WeatherDetailItem(
                label: 'Humidity',
                value: '${selectedDay.humidity.toStringAsFixed(1)}%',
              ),
              WeatherDetailItem(
                label: 'Rainy',
                value: selectedDay.isRainy ? "Yes" : "No",
              ),
              SizedBox(height: isSmallScreen ? 16 : 24),
              Center(
                child: ElevatedButton.icon(
                  onPressed: isLoadingAI ? null : onRecommendationPressed,
                  icon: isLoadingAI
                      ? SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.blue.shade800,
                            strokeWidth: 2,
                          ),
                        )
                      : const Icon(Icons.smart_toy),
                  label: Text(
                    isLoadingAI ? 'AI Thinking...' : 'Should I Go Outside?',
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue.shade800,
                    padding: EdgeInsets.symmetric(
                      horizontal: isSmallScreen ? 16 : 20,
                      vertical: isSmallScreen ? 10 : 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
