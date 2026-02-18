import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/weather.dart';

class HourlyItem extends StatelessWidget {
  final HourlyWeather hour;
  final bool active;

  const HourlyItem({super.key, required this.hour, required this.active});

  IconData _icon(String condition) {
    final c = condition.toLowerCase();
    if (c.contains('thunder')) return Icons.thunderstorm;
    if (c.contains('rain') || c.contains('drizzle')) return Icons.grain;
    if (c.contains('cloud')) return Icons.cloud;
    if (c.contains('clear')) return Icons.wb_sunny;
    return Icons.cloud;
  }

  @override
  Widget build(BuildContext context) {
    final time = DateFormat('HH:mm').format(hour.time);

    return Container(
      width: 70,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: active
            ? const Color(0xFF0C4FAE).withOpacity(0.9)
            : Colors.white.withOpacity(0.10),
        borderRadius: BorderRadius.circular(16),
        border:
            active ? Border.all(color: Colors.white.withOpacity(0.35)) : null,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(time,
              style: const TextStyle(color: Colors.white70, fontSize: 12)),
          const SizedBox(height: 8),
          Icon(_icon(hour.condition), color: Colors.white, size: 20),
          const SizedBox(height: 8),
          Text('${hour.temp.round()}°',
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}
