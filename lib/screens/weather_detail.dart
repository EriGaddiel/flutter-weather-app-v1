import 'package:flutter/material.dart';
import './../components/daily_forecast.dart';
class WeatherDetail extends StatefulWidget {
  const WeatherDetail({super.key});

  @override
  State<WeatherDetail> createState() => _WeatherDetailState();
}

class _WeatherDetailState extends State<WeatherDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0Xff331C71),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.only(left: 22.0, right: 22),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Color(0xff5842A9), 
                        borderRadius: BorderRadius.circular(12)
                      ),
                      child: Icon(Icons.arrow_back, color: Colors.white,),
                    ),
                    Text('7-Days', style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25, 
                      color: Colors.white),),
                    Container(
                        height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Color(0xff5842A9), 
                        borderRadius: BorderRadius.circular(12)
                      ),
                          
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Image(color: Colors.white, image: AssetImage('assets/icons/dots (1).png', )),
                    ),
                  ),
                  ],
                ),
                SizedBox(height: 20,),
                Container(
                  height: 320,
                  width: 400,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(78, 211, 211, 211),
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Row(
                            children: [
                              Image(
                                height: 150,
                                image: AssetImage('assets/icons/cloudy (1).png')),
                                Column(
                                  children: [
                                    Text('Tommorow', style: TextStyle(color: Colors.white),),
                                    SizedBox(height: 15,),
                                    Text('Mostly cloudy', style: TextStyle(
                                      color: Colors.white, 
                                      fontSize: 18
                                    ) ,),
                                  ],
                                )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 80.0, left: 70),
                            child: Text('19°', style: TextStyle(
                              color: Colors.white,
                              fontSize: 80,
                              fontWeight: FontWeight.bold
                            ),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 140.0, left: 150),
                            child: Text('/15°', style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold
                            ),),
                          ), 
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 18.0, left: 8),
                            child: Column(
                              children: [
                                Image(height: 30, image: AssetImage('assets/icons/protection.png')),
                                Text('30', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),),
                                Text('Pracipitaion', style: TextStyle(fontSize: 16, color: Colors.white),),
                              ],
                            ),
                          ),
            
                          Padding(
                            padding: const EdgeInsets.only(top: 18.0, left: 8),
                            child: Column(
                              children: [
                                Image(height: 30, image: AssetImage('assets/icons/drop.png')),
                                Text('30', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),),
                                Text('Humidity', style: TextStyle(fontSize: 16, color: Colors.white),),
                              ],
                            ),
                          ),
                          
                          Padding(
                            padding: const EdgeInsets.only(top: 18.0, right: 8),
                            child: Column(
                              children: [
                                Image(height: 30, image: AssetImage('assets/icons/wind.png')),
                                Text('30', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),),
                                Text('Wind speed', style: TextStyle(fontSize: 16, color: Colors.white),),
                              ],
                            ),
                          ),
                        ],
                      ),                    
                    ],),
                ),
                SizedBox(height: 20,),
                DailyForecast(),
                DailyForecast(),
                DailyForecast(),
                DailyForecast(),
                DailyForecast(),
                DailyForecast(),
                DailyForecast(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

