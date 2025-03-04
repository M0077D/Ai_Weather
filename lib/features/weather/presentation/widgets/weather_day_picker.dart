import 'package:flutter/material.dart';
import 'package:task1/features/weather/domain/entities/weather_entity.dart';

class WeatherDayPicker extends StatelessWidget {
  final List<DailyWeatherEntity> weatherDays;
  final int selectedIndex;
  final Function(int) onDaySelected;

  const WeatherDayPicker({
    Key? key,
    required this.weatherDays,
    required this.selectedIndex,
    required this.onDaySelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isSmallScreen = constraints.maxWidth < 600;
        final double itemWidth = (constraints.maxWidth - 32) / 3;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            weatherDays.length > 3 ? 3 : weatherDays.length,
            (index) {
              final day = weatherDays[index];
              return GestureDetector(
                onTap: () => onDaySelected(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: itemWidth,
                  padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
                  decoration: BoxDecoration(
                    color: selectedIndex == index
                        ? Colors.white.withOpacity(0.3)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.5),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        _getDayOfWeek(day.date),
                        style: TextStyle(
                          fontSize: isSmallScreen ? 16 : 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: isSmallScreen ? 4 : 8),
                      Text(
                        '${day.avgTemp.toStringAsFixed(1)}°C',
                        style: TextStyle(
                          fontSize: isSmallScreen ? 14 : 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  String _getDayOfWeek(String date) {
    final DateTime dateTime = DateTime.parse(date);
    switch (dateTime.weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }
}
