import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task1/core/services/location_service.dart';
import 'package:task1/features/weather/presentation/providers/user_provider.dart';
import 'package:task1/features/weather/presentation/providers/weather_provider.dart';
import 'package:task1/features/weather/presentation/providers/ai_weather_provider.dart';
import 'package:task1/features/weather/presentation/widgets/weather_app_bar.dart';
import 'package:task1/features/weather/presentation/widgets/user_greeting.dart';
import 'package:task1/features/weather/presentation/widgets/weather_day_picker.dart';
import 'package:task1/features/weather/presentation/widgets/weather_details_card.dart';
import 'package:task1/features/weather/presentation/widgets/loading_indicator.dart';
import 'package:task1/features/weather/presentation/widgets/outdoor_recommendation_dialog.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  int _selectedDayIndex = 0;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final weatherProvider =
        Provider.of<WeatherProvider>(context, listen: false);

    userProvider.fetchUser();
    await _fetchWeather(weatherProvider);
  }

  Future<void> _fetchWeather(WeatherProvider weatherProvider) async {
    try {
      final location = await LocationService().getCurrentLocation();
      await weatherProvider.fetchWeather(location.latitude, location.longitude);

      if (weatherProvider.weather != null) {
        final aiWeatherProvider =
            Provider.of<AiWeatherProvider>(context, listen: false);
        await aiWeatherProvider
            .predictOutdoorActivity(weatherProvider.weather!);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  void _onDaySelected(int index) {
    setState(() {
      _selectedDayIndex = index;
    });
  }

  void _showRecommendationDialog() {
    final aiWeatherProvider =
        Provider.of<AiWeatherProvider>(context, listen: false);
    if (aiWeatherProvider.prediction != null) {
      showDialog(
        context: context,
        builder: (context) => OutdoorRecommendationDialog(
          prediction: aiWeatherProvider.prediction!,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    final aiWeatherProvider = Provider.of<AiWeatherProvider>(context);

    return Scaffold(
      appBar: const WeatherAppBar(),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          //color: const Color(0xff010522),

          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xff014BB4), Color(0xff010522)],
          ),
        ),
        child: SafeArea(
          child: weatherProvider.isLoading
              ? const LoadingIndicator(
                  message: 'Getting weather information...')
              : LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SizedBox(
                                  height: constraints.maxWidth < 600 ? 16 : 32),
                              if (userProvider.user != null)
                                UserGreeting(name: userProvider.user!.name),
                              SizedBox(
                                  height: constraints.maxWidth < 600 ? 20 : 32),
                              if (weatherProvider.weather != null)
                                WeatherDayPicker(
                                  weatherDays:
                                      weatherProvider.weather!.dailyWeather,
                                  selectedIndex: _selectedDayIndex,
                                  onDaySelected: _onDaySelected,
                                ),
                              SizedBox(
                                  height: constraints.maxWidth < 600 ? 20 : 32),
                              if (weatherProvider.weather != null)
                                WeatherDetailsCard(
                                  selectedDay: weatherProvider
                                      .weather!.dailyWeather[_selectedDayIndex],
                                  isLoadingAI: aiWeatherProvider.isLoading,
                                  onRecommendationPressed:
                                      _showRecommendationDialog,
                                ),
                              SizedBox(
                                  height: constraints.maxWidth < 600 ? 16 : 32),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: weatherProvider.isLoading
            ? null
            : () async {
                final weatherProvider =
                    Provider.of<WeatherProvider>(context, listen: false);
                await _fetchWeather(weatherProvider);
              },
        backgroundColor: Colors.white,
        child: weatherProvider.isLoading
            ? CircularProgressIndicator(color: Colors.blue)
            : Icon(Icons.refresh, color: Colors.blue),
      ),
    );
  }
}
