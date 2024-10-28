class DailyWeatherModel {
  final String date;
  final double minTemperature;
  final double maxTemperature;
  final double humidity;
  final double precipitation;
  final double windSpeed;
  final String weatherDescription;
  final String icon;

  DailyWeatherModel({
    required this.date,
    required this.minTemperature,
    required this.maxTemperature,
    required this.humidity,
    required this.precipitation,
    required this.windSpeed,
    required this.weatherDescription,
    required this.icon,
  });

  factory DailyWeatherModel.fromJson(Map<String, dynamic> json) {
    return DailyWeatherModel(
      date: json['dt'] != null ? DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000).toString().split(' ')[0] : '',
      minTemperature: json['temp']['min'].toDouble(),
      maxTemperature: json['temp']['max'].toDouble(),
      humidity: json['humidity'].toDouble(),
      precipitation: json['rain'] != null ? json['rain'].toDouble() : 0.0, 
      windSpeed: json['wind_speed'].toDouble(),
      weatherDescription: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
    );
  }
}