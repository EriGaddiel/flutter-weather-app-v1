import 'package:flutter/material.dart';

class CityWeatherInfo extends StatelessWidget {
  final String cityName;
  final String weatherDescription;
  final String temperature;
  final String iconPath;

  const CityWeatherInfo({
    Key? key,
    required this.cityName,
    required this.weatherDescription,
    required this.temperature,
    required this.iconPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 70,
          width: 250,
          decoration: BoxDecoration(
            color: const Color.fromARGB(78, 211, 211, 211),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(height: 40, image: NetworkImage(iconPath)), // Dynamically use the icon
                Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          cityName,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      Text(
                        weatherDescription,
                        style: const TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Text(
                    '$temperature°', // Dynamically show the temperature
                    style: const TextStyle(fontSize: 30, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 20,)
      ],
    );
  }
}
