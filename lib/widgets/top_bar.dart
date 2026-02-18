import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import 'city_picker_sheet.dart';

class TopBar extends StatefulWidget {
  final String city;
  final String dateStr;

  const TopBar({
    super.key,
    required this.city,
    required this.dateStr,
  });

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  final List<String> cities = [
    "Riyadh",
    "Jeddah",
    "Dammam",
    "Makkah",
    "Madinah",
    "Abha",
    "Dubai",
    "London",
    "Paris",
    "Tokyo",
    "New York",
    "Berlin",
    "Rome",
    "Istanbul",
    "Cairo",
    "Amman",
    "Doha",
    "Kuwait City",
    "Manama",
    "Muscat",
  ];

  late String selectedCity;

  @override
  void initState() {
    super.initState();
    selectedCity = cities.contains(widget.city) ? widget.city : cities.first;
  }

  @override
  void didUpdateWidget(covariant TopBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.city != widget.city && cities.contains(widget.city)) {
      selectedCity = widget.city;
    }
  }

  Future<void> _openCitySheet() async {
    final chosen = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.35),
      builder: (_) => CityPickerSheet(
        cities: cities,
        selectedCity: selectedCity,
      ),
    );

    if (chosen == null) return;

    setState(() => selectedCity = chosen);
    context.read<WeatherProvider>().fetchWeather(chosen);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          const Icon(Icons.grid_view_rounded, color: Colors.white70),
          const Spacer(),
          InkWell(
            onTap: _openCitySheet,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.location_on,
                          color: Colors.white, size: 18),
                      const SizedBox(width: 6),
                      Text(
                        selectedCity,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Icon(Icons.keyboard_arrow_down,
                          color: Colors.white.withOpacity(0.85)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.dateStr,
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: _openCitySheet,
            icon: const Icon(Icons.more_horiz, color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
