import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import '../widgets/today_weather_card.dart';

class HomeWeatherPage extends StatefulWidget {
  const HomeWeatherPage({super.key});

  @override
  State<HomeWeatherPage> createState() => _HomeWeatherPageState();
}

class _HomeWeatherPageState extends State<HomeWeatherPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WeatherProvider>().fetchWeather('Riyadh');
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: TodayWeatherCard(),
    );
  }
}
