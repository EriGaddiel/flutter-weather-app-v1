import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'dart:convert';

import './weather_detail.dart';
import './../components/hourly_forecast_card.dart';
import './../components/other_cities_weather_info_card.dart';
import './../controllers/weather_controller.dart';
import './../models/weather_model.dart';
import './../models/hourly_weather_model.dart';
import '../models/daily_weather_model.dart';
import './../models/city_model.dart';
import './../utils.dart';
class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CityModel? selectedCity;
  WeatherModel? currentWeather;
  late Future<List<WeatherModel>> weatherData;
  
  final WeatherService _weatherService = WeatherService();
  List<HourlyWeatherModel>? _hourlyForecast;
  late Future<List<DailyWeatherModel>> dailyForecastData;
  // Replace with the list of CityModel instances
  final List<CityModel> cities = [
    CityModel(name: 'Yaounde', imagePath: 'assets/images/yaounde.jpeg'),
    CityModel(name: 'Douala', imagePath: 'assets/images/douala.jpeg'),
    CityModel(name: 'Buea', imagePath: 'assets/images/buea.jpeg'),
    CityModel(name: 'Limbe', imagePath: 'assets/images/limbe.jpeg'),
    CityModel(name: 'Bamenda', imagePath: 'assets/images/bamenda.jpeg'),
    CityModel(name: 'Garoua', imagePath: 'assets/images/garoua.jpeg'),
    CityModel(name: 'Maroua', imagePath: 'assets/images/maroua.jpeg'),
    CityModel(name: 'Ngaoundéré', imagePath: 'assets/images/ngaoundéré.jpeg'),
    CityModel(name: 'Ebolowa', imagePath: 'assets/images/ebolowa.jpeg'),
    CityModel(name: 'Kribi', imagePath: 'assets/images/kribi.jpeg'),
  ];

  

  Future<void> fetchWeatherForSelectedCity() async {
    try {
      final response = await http.get(
        Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=${selectedCity!.name}&appid=${_weatherService.apiKey}&units=metric',
        ),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          currentWeather = WeatherModel.fromJson(data);
        });
      } else {
        throw Exception('Failed to load weather data for ${selectedCity!.name}');
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> fetchHourlyWeather(String cityName) async {
    try {
      List<HourlyWeatherModel> forecast = await _weatherService.fetchHourlyWeather(cityName);
      setState(() {
        _hourlyForecast = forecast;
      });
    } catch (e) {
      print('Error fetching hourly weather: $e');
    }
  }

    Future<void> fetchDailyForecast() async {
    if (selectedCity != null) {
      try {
        dailyForecastData = _weatherService.fetch7DayForecast(selectedCity!.name); 
      } catch (e) {
        print('Error fetching daily forecast: $e');
      }
    }
  }

 
void refreshWeatherData() {
  // Refresh data for the selected city
  fetchWeatherForSelectedCity();
  // Refresh data for other cities
  setState(() {
    fetchWeatherForSelectedCity();
    fetchHourlyWeather(selectedCity!.name);
    fetchDailyForecast();
    weatherData = _weatherService.fetchWeatherData();
  });
}


@override
  void initState() {
    super.initState();
    selectedCity = cities[0];
    fetchWeatherForSelectedCity();
    fetchHourlyWeather(selectedCity!.name);
    weatherData = _weatherService.fetchWeatherData(); // Fetch other cities' weather
 }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff5842A9),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [

           Image.asset(
            selectedCity?.imagePath ?? cities[0].imagePath,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
           ),

           BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: Colors.black.withOpacity(0.5), // Optional: Add a semi-transparent overlay
            ),
          ),
           
          SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(78, 211, 211, 211), 
                                  borderRadius: BorderRadius.circular(12)
                                ),
                                child: Image(
                                  color: Colors.white,
                                  image: AssetImage('assets/icons/menu1.png'),),
                              ),
                              
                            DropdownButton<CityModel>(
                              value: selectedCity,
                              items: cities.map((CityModel city) {
                              return DropdownMenuItem<CityModel>(
                                value: city,
                                child: Text(
                                city.name,
                                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            );
                          }).toList(),
                          onChanged: (CityModel? newValue) {
                            setState(() {
                              selectedCity = newValue;
                              fetchWeatherForSelectedCity();
                          });
                        },
                          dropdownColor: Color.fromARGB(118, 27, 27, 27),
                          style: TextStyle(color: Colors.white),
                          iconEnabledColor: Colors.white, // Icon color
                        ),
                              
                            GestureDetector(
                              onTap: refreshWeatherData, // Call the refresh method on tap
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(78, 211, 211, 211),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Icon(
                                    Icons.refresh,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          ],
                      ),
                    ),
            
                    SizedBox(height: 20,),
            
                    Text(
                         currentWeather != null ? currentWeather!.weatherDescription : '', // Use the dynamic description
                         style: TextStyle(color: Colors.white),
                    ),
                    Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Text('${currentWeather != null ? currentWeather!.temperature.toStringAsFixed(1) : 'N/A '}°', style: TextStyle(
                          fontSize: 150, 
                          color: Colors.white, 
                          fontWeight: FontWeight.bold
                        ),),               
                        Opacity(opacity: 0.6,
                          child: Padding(
                            padding: EdgeInsets.only(left: 50.0, top: 80.0),
                            child: currentWeather != null ? Image(
                              height: 250, 
                              width: 400,
                              fit: BoxFit.cover,
                              image: NetworkImage(getIconUrl(currentWeather!.icon))
                              ) : Container(height: 10, width: 10, color: Colors.red,),
                            )
                          ),
                    ]),
            
                    const Text('Saturday, 10 June 2024', style: TextStyle(color: Colors.white),),
                    SizedBox(height: 20,),
                    Container(
                      height: 120,
                      width: 350,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(78, 211, 211, 211), 
                        borderRadius: BorderRadius.circular(16)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 18.0, left: 8),
                            child: Column(
                              children: [
                                Image(height: 40, image: AssetImage('assets/icons/protection.png')),
                                Text(currentWeather != null ?(currentWeather!.precipitation?.toStringAsFixed(1) ?? '0.0') + ' mm'  : '0.0 mm', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),),
                                Text('Pracipitaion', style: TextStyle(fontSize: 16, color: Colors.white),),
                              ],
                            ),
                          ),
            
                          Padding(
                            padding: const EdgeInsets.only(top: 18.0, left: 8),
                            child: Column(
                              children: [
                                Image(height: 40, image: AssetImage('assets/icons/drop.png')),
                                Text(currentWeather != null ? currentWeather!.humidity.toStringAsFixed(1) + '%'  : '0.0 %', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),),
                                Text('Humidity', style: TextStyle(fontSize: 16, color: Colors.white),),
                              ],
                            ),
                          ),
                          
                          Padding(
                            padding: const EdgeInsets.only(top: 18.0, right: 8),
                            child: Column(
                              children: [
                                Image(height: 40, image: AssetImage('assets/icons/wind.png')),
                                Text(currentWeather != null ? currentWeather!.windSpeed.toStringAsFixed(1) + ' m/s'  : '0.0 m/s', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),),
                                Text('Wind speed', style: TextStyle(fontSize: 16, color: Colors.white),),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                   SizedBox(height: 20,),
                   Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Today", 
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white
                              ),),
                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => WeatherDetail()));
                          },
                          child: Text("7-Days Forecate", 
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white
                                ),),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                  Container(
                    child: _hourlyForecast == null ?  Center(child: CircularProgressIndicator()) 
                         :SizedBox(
                          height: 150,
                           child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: _hourlyForecast!.length,
                              itemBuilder: (context, index) {
                                final hourlyData = _hourlyForecast![index];
                                final hour = '${hourlyData.dateTime.hour} ${hourlyData.dateTime.minute == 0 ? "AM" : "PM"}'; // Display AM/PM
                                return HourlyForecastCard(
                                    time: hour,
                                    temperature: '${hourlyData.temperature.toString()}°',
                                    weatherIconPath: getIconUrl(hourlyData.icon), // Adjust based on the actual weather conditions
                                );
                              },
                           ),
                         )
                    
                  ),
                  SizedBox(height: 20,),
                   Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Other Cities", 
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white
                              ),),
                        Text("+", 
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white
                              ),),
                      ],
                    ),
                    SizedBox(height: 10,),
                    FutureBuilder<List<WeatherModel>>(
                      future: weatherData,  // This should be set according to the selected city
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator(color: Colors.white,));
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}', style: TextStyle(color: Colors.white)));
                        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Center(child: Text('No data available', style: TextStyle(color: Colors.white),));
                        }
        
                        final weatherList = snapshot.data!;

                        final filteredWeatherList = weatherList.where((weather) => weather.cityName != selectedCity?.name).toList();

                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: filteredWeatherList.map((weather) {
                              return CityWeatherInfo(
                                cityName: weather.cityName, // Ensure WeatherModel has this property
                                weatherDescription: weather.weatherDescription, // Ensure this property exists
                                temperature: weather.temperature.toStringAsFixed(1),
                                iconPath: getIconUrl(weather.icon), // Ensure getIconUrl function is defined
                              );
                            }).toList(),
                          ),
                        );
                      },
                    ),
        
                  ],
                ),
              ),
            ),
          ),
        ),
        ],
      ),
    );
  }
}

