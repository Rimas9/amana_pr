import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../providers/weather_provider.dart';
import 'top_bar.dart';
import 'weather_card.dart';
import 'bottom_panel.dart';
import 'weather_skeleton.dart';

class TodayWeatherCard extends StatelessWidget {
  const TodayWeatherCard({super.key});

  Color _bgTop() => const Color(0xFF2FC4FF);
  Color _bgBottom() => const Color(0xFF0B6FE6);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<WeatherProvider>();

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [_bgTop(), _bgBottom()],
        ),
      ),
      child: SafeArea(
        child: Builder(
          builder: (_) {
            if (provider.isLoading) {
              return const Padding(
                padding: EdgeInsets.all(16),
                child: WeatherSkeleton(),
              );
            }

            if (provider.error != null) {
              return Center(
                child: Text(
                  provider.error!,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              );
            }

            if (provider.today == null) return const SizedBox();

            final w = provider.today!;
            final dateStr = DateFormat('EEEE, d MMM').format(DateTime.now());

            return Column(
              children: [
                TopBar(city: w.city, dateStr: dateStr),
                Expanded(flex: 6, child: WeatherCard(weather: w)),
                Expanded(flex: 5, child: BottomPanel(weather: w)),
              ],
            );
          },
        ),
      ),
    );
  }
}
