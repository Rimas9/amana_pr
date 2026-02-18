import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/weather.dart';

class DailyItem extends StatelessWidget {
  final DailyWeather day;
  const DailyItem({super.key, required this.day});

  IconData _icon(String condition) {
    final c = condition.toLowerCase();
    if (c.contains('thunder')) return Icons.thunderstorm;
    if (c.contains('rain') || c.contains('drizzle')) return Icons.grain;
    if (c.contains('cloud')) return Icons.cloud;
    if (c.contains('clear')) return Icons.wb_sunny;
    return Icons.cloud;
  }

  String _title(String main) {
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
    final dayName = DateFormat('EEE').format(day.date);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(
            width: 46,
            child: Text(dayName,
                style: const TextStyle(color: Colors.white70, fontSize: 13)),
          ),
          const SizedBox(width: 10),
          Icon(_icon(day.condition), color: Colors.white, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              _title(day.condition),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white70, fontSize: 13),
            ),
          ),
          Text('${day.max.round()}°',
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w700)),
          const SizedBox(width: 8),
          Text('${day.min.round()}°',
              style: const TextStyle(color: Colors.white54)),
        ],
      ),
    );
  }
}
