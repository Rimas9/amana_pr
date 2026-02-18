import 'package:flutter/material.dart';
import '../data/weather.dart';
import 'weather_info_item.dart';

class WeatherCard extends StatelessWidget {
  final Weather weather;
  const WeatherCard({super.key, required this.weather});

  bool _isClear(String condition) => condition.toLowerCase().contains('clear');

  IconData _mainIcon(String condition) {
    final c = condition.toLowerCase();
    if (c.contains('thunder')) return Icons.thunderstorm;
    if (c.contains('rain') || c.contains('drizzle')) return Icons.grain;
    if (c.contains('snow')) return Icons.ac_unit;
    if (c.contains('mist') || c.contains('fog') || c.contains('haze'))
      return Icons.foggy;
    if (c.contains('cloud')) return Icons.cloud;
    if (c.contains('clear')) return Icons.wb_sunny;
    return Icons.cloud;
  }

  String _prettyTitle(String main) {
    switch (main.toLowerCase()) {
      case 'thunderstorm':
        return 'Thunderstorm';
      case 'clouds':
        return 'Cloudy';
      case 'rain':
        return 'Rainy';
      case 'clear':
        return 'Clear';
      default:
        return main;
    }
  }

  @override
  Widget build(BuildContext context) {
    final w = weather;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 12),
            Container(
              height: 160,
              width: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.07),
              ),
              child: Icon(
                _mainIcon(w.condition),
                size: 100,
                color: _isClear(w.condition)
                    ? Colors.yellow
                    : Colors.white.withOpacity(0.95),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              '${w.temp.round()}°',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 68,
                  fontWeight: FontWeight.w700,
                  height: 1),
            ),
            const SizedBox(height: 6),
            Text(
              _prettyTitle(w.condition),
              style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  WeatherInfoItem(
                      icon: Icons.air,
                      value: '${w.windKmh.round()} km/h',
                      label: 'Wind'),
                  WeatherInfoItem(
                      icon: Icons.water_drop,
                      value: '${w.humidity}%',
                      label: 'Humidity'),
                  WeatherInfoItem(
                      icon: Icons.umbrella,
                      value: '${w.chanceOfRain}%',
                      label: 'Chance of rain'),
                ],
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
