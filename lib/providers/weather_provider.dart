import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../data/weather.dart';

class WeatherProvider extends ChangeNotifier {
  static const String _apiKey = '72fff7e2e5f50132f05ec0792b00432b';
  static const String _host = 'api.openweathermap.org';

  Weather? today;
  bool isLoading = false;
  String? error;

  Future<void> fetchWeather(String city) async {
    final queryCity = city.trim();
    if (queryCity.isEmpty) return;

    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final currentUrl = Uri.https(
        _host,
        '/data/2.5/weather',
        {
          'q': queryCity,
          'appid': _apiKey,
          'units': 'metric',
        },
      );

      final forecastUrl = Uri.https(
        _host,
        '/data/2.5/forecast',
        {
          'q': queryCity,
          'appid': _apiKey,
          'units': 'metric',
        },
      );

      final currentRes = await http.get(currentUrl);
      final forecastRes = await http.get(forecastUrl);

      if (currentRes.statusCode != 200) {
        final body = jsonDecode(currentRes.body);
        throw Exception(body['message']?.toString() ?? 'City not found');
      }
      if (forecastRes.statusCode != 200) {
        final body = jsonDecode(forecastRes.body);
        throw Exception(body['message']?.toString() ?? 'Forecast failed');
      }

      final currentJson = json.decode(currentRes.body) as Map<String, dynamic>;
      final forecastJson =
          json.decode(forecastRes.body) as Map<String, dynamic>;

      final cityName = (currentJson['name'] ?? queryCity).toString();

      final temp = (currentJson['main']['temp'] as num).toDouble();
      final humidity = (currentJson['main']['humidity'] as num).toInt();
      final windMs = ((currentJson['wind']?['speed'] ?? 0) as num).toDouble();
      final windKmh = windMs * 3.6;

      final weather0 =
          (currentJson['weather'] as List).first as Map<String, dynamic>;
      final condition = (weather0['main'] ?? '').toString();
      final description = (weather0['description'] ?? '').toString();

      final list = (forecastJson['list'] as List).cast<Map<String, dynamic>>();

      final hourly = list.take(8).map((h) {
        final dt = DateTime.fromMillisecondsSinceEpoch(
            (h['dt'] as num).toInt() * 1000);
        final t = (h['main']['temp'] as num).toDouble();
        final w = (h['weather'] as List).first as Map<String, dynamic>;
        final c = (w['main'] ?? '').toString();
        return HourlyWeather(time: dt, temp: t, condition: c);
      }).toList();

      int chance = 0;
      final pop = (list.first['pop'] as num?)?.toDouble();
      if (pop != null) chance = (pop * 100).round();

      final Map<String, List<Map<String, dynamic>>> byDay = {};
      for (final item in list) {
        final dt = DateTime.fromMillisecondsSinceEpoch(
            (item['dt'] as num).toInt() * 1000);
        final key = '${dt.year}-${dt.month}-${dt.day}';
        byDay.putIfAbsent(key, () => []).add(item);
      }

      final daily = <DailyWeather>[];
      final keys = byDay.keys.toList()..sort((a, b) => a.compareTo(b));

      for (final k in keys) {
        final items = byDay[k]!;
        double minT = double.infinity, maxT = -double.infinity;

        final Map<String, int> freq = {};
        for (final it in items) {
          final t = (it['main']['temp'] as num).toDouble();
          if (t < minT) minT = t;
          if (t > maxT) maxT = t;

          final w = (it['weather'] as List).first as Map<String, dynamic>;
          final c = (w['main'] ?? 'Clouds').toString();
          freq[c] = (freq[c] ?? 0) + 1;
        }

        final dayCond =
            freq.entries.reduce((a, b) => a.value >= b.value ? a : b).key;

        final firstDt = DateTime.fromMillisecondsSinceEpoch(
            (items.first['dt'] as num).toInt() * 1000);
        daily.add(
          DailyWeather(
            date: DateTime(firstDt.year, firstDt.month, firstDt.day),
            max: maxT,
            min: minT,
            condition: dayCond,
          ),
        );
      }

      today = Weather(
        city: cityName,
        temp: temp,
        condition: condition,
        description: description,
        windKmh: windKmh,
        humidity: humidity,
        chanceOfRain: chance,
        hourly: hourly,
        daily: daily,
      );
    } catch (e) {
      error = 'صار خطأ: ${e.toString().replaceFirst('Exception: ', '')}';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
