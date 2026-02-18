import 'package:flutter/material.dart';
import '../data/weather.dart';
import 'hourly_item.dart';
import 'daily_item.dart';

class BottomPanel extends StatelessWidget {
  final Weather weather;
  const BottomPanel({super.key, required this.weather});

  Color _panel() => const Color(0xFF0A3F8E);

  @override
  Widget build(BuildContext context) {
    final w = weather;

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 18),
      decoration: BoxDecoration(
        color: _panel().withOpacity(0.55),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
      ),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const Text(
            'Today',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 110,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: w.hourly.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (context, i) {
                return HourlyItem(
                  hour: w.hourly[i],
                  active: i == 0,
                );
              },
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            '7 days',
            style: TextStyle(color: Colors.white70, fontSize: 13),
          ),
          const SizedBox(height: 10),
          ...w.daily.take(7).map((d) => DailyItem(day: d)),
        ],
      ),
    );
  }
}
