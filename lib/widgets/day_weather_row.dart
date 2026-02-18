import 'package:flutter/material.dart';

class DayWeatherRow extends StatelessWidget {
  final String day;
  final int max;
  final int min;

  const DayWeatherRow({
    super.key,
    required this.day,
    required this.max,
    required this.min,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Row(
        children: [
          SizedBox(
            width: 40,
            child: Text(day, style: const TextStyle(color: Colors.white)),
          ),
          const Icon(Icons.cloud, color: Colors.white70),
          const Spacer(),
          Text('+$max°',
              style: const TextStyle(color: Colors.white, fontSize: 14)),
          const SizedBox(width: 6),
          Text('+$min°',
              style: const TextStyle(color: Colors.white54, fontSize: 14)),
        ],
      ),
    );
  }
}
