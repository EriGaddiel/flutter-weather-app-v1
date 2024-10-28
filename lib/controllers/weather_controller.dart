import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';
import '../models/hourly_weather_model.dart';
import '../models/daily_weather_model.dart';
import './../models/city_model.dart';

class WeatherService {
  final String apiKey = 'ae7faeba1dc509a966b2de9c68592fc4'; // Your OpenWeatherMap API key
  final List<CityModel> cities = [
    CityModel(name: 'Yaounde', imagePath: 'assets/images/yaounde.png'),
    CityModel(name: 'Douala', imagePath: 'assets/images/douala.png'),
    CityModel(name: 'Buea', imagePath: 'assets/images/buea.png'),
    CityModel(name: 'Limbe', imagePath: 'assets/images/limbe.png'),
    CityModel(name: 'Bamenda', imagePath: 'assets/images/bamenda.png'),
    CityModel(name: 'Garoua', imagePath: 'assets/images/garoua.png'),
    CityModel(name: 'Maroua', imagePath: 'assets/images/maroua.png'),
    CityModel(name: 'Ngaoundéré', imagePath: 'assets/images/ngaoundéré.png'),
    CityModel(name: 'Ebolowa', imagePath: 'assets/images/ebolowa.png'),
    CityModel(name: 'Kribi', imagePath: 'assets/images/kribi.png'),
  ];

  Future<List<WeatherModel>> fetchWeatherData() async {
    List<WeatherModel> weatherList = [];

    for (CityModel city in cities) {
      final response = await _getHttpResponse('https://api.openweathermap.org/data/2.5/weather?q=${city.name}&appid=$apiKey&units=metric');
      
      if (response != null) {
        WeatherModel weather = WeatherModel.fromJson(response);
        weatherList.add(weather);
      } else {
        throw Exception('Failed to load weather data for ${city.name}');
      }
    }

    return weatherList;
  }

  Future<List<HourlyWeatherModel>> fetchHourlyWeather(String cityName) async {
    final response = await _getHttpResponse('https://api.openweathermap.org/data/2.5/forecast?q=$cityName&appid=$apiKey&units=metric');
    
    if (response != null) {
      return (response['list'] as List)
          .map((hourData) => HourlyWeatherModel.fromJson(hourData))
          .toList();
    } else {
      throw Exception('Failed to load hourly weather data for $cityName');
    }
  }

  Future<Map<String, double>?> getCoordinates(String cityName) async {
    final url = Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey');

    final response = await _getHttpResponse(url.toString());

    if (response != null) {
      final double lat = response['coord']['lat'];
      final double lon = response['coord']['lon'];
      return {'latitude': lat, 'longitude': lon};
    } else {
      print('Error fetching coordinates for ${cityName}');
      return null;
    }
  }

  Future<List<DailyWeatherModel>> fetch7DayForecast(String cityName) async {
    final coordinates = await getCoordinates(cityName);
    
    if (coordinates == null) {
      throw Exception('Could not retrieve coordinates for $cityName.');
    }

    final response = await _getHttpResponse(
      'https://api.openweathermap.org/data/2.5/onecall?lat=${coordinates['latitude']}&lon=${coordinates['longitude']}&exclude=hourly,minutely&appid=$apiKey&units=metric',
    );

    if (response != null) {
      return (response['daily'] as List)
          .map((dayJson) => DailyWeatherModel.fromJson(dayJson))
          .toList();
    } else {
      throw Exception('Failed to load 7-day forecast');
    }
  }

  Future<Map<String, dynamic>?> _getHttpResponse(String url) async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return null;
      }
    } catch (e) {

      return null;
    }
  }
}