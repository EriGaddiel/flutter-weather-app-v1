import 'package:flutter/material.dart';

class HourlyForecastCard extends StatelessWidget {
  final String time;
  final String temperature;
  final String weatherIconPath; // Path to an icon image

  const HourlyForecastCard({
    required this.time,
    required this.temperature,
    required this.weatherIconPath,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 140,
          width: 70,
          decoration: BoxDecoration(
            color: const Color.fromARGB(78, 211, 211, 211),
            borderRadius: BorderRadius.circular(16)
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(child: Text(time, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),)),
                Image(height: 60, width: 80, image: NetworkImage(weatherIconPath)),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(child: Text(temperature, style: TextStyle(fontSize: 16, color: Colors.white),)),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 10,),
      ],
    );
  }
}
