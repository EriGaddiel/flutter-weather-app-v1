class WeatherModel {
  final String cityName;
  final double temperature;
  final String weatherDescription;
  final String icon;
  final double windSpeed; 
  final double humidity; 
  final double? precipitation; 

  WeatherModel({
    required this.cityName,
    required this.temperature,
    required this.weatherDescription,
    required this.icon,
    required this.windSpeed,
    required this.humidity,
    this.precipitation, // Optional
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      weatherDescription: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
      windSpeed: json['wind']['speed'].toDouble(), 
      humidity: json['main']['humidity'].toDouble(), 
      precipitation: json['rain'] != null ? json['rain']['1h']?.toDouble()  ?? 0.0 : null, 
    );
  }
}