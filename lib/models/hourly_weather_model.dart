class HourlyWeatherModel {
  final DateTime dateTime;
  final double temperature;
  final String icon;

  HourlyWeatherModel({
    required this.dateTime,
    required this.temperature,
    required this.icon
  });

  factory HourlyWeatherModel.fromJson(Map<String, dynamic> json) {
    return HourlyWeatherModel(
      dateTime: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
      temperature: json['main']['temp'].toDouble(),
      icon: json['weather'][0]['icon'],
    );
  }
}