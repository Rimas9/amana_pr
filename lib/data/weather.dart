class Weather {
  final String city;
  final double temp;
  final String condition;
  final String description;
  final double windKmh;
  final int humidity;
  final int chanceOfRain;

  final List<HourlyWeather> hourly;
  final List<DailyWeather> daily;

  Weather({
    required this.city,
    required this.temp,
    required this.condition,
    required this.description,
    required this.windKmh,
    required this.humidity,
    required this.chanceOfRain,
    required this.hourly,
    required this.daily,
  });
}

class HourlyWeather {
  final DateTime time;
  final double temp;
  final String condition;

  HourlyWeather({
    required this.time,
    required this.temp,
    required this.condition,
  });
}

class DailyWeather {
  final DateTime date;
  final double max;
  final double min;
  final String condition;

  DailyWeather({
    required this.date,
    required this.max,
    required this.min,
    required this.condition,
  });
}
