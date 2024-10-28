import 'package:flutter/material.dart';

class DailyForecast extends StatelessWidget {
  const DailyForecast({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Monday',style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
            Row(
              children: [
                Image(height: 40,image: AssetImage('assets/icons/cloud.png')),
                Text('Wind', style: TextStyle(color: Colors.white),)
              ],
            ),
        Text('+22', style: TextStyle(color: Colors.white),),
        Text('+18', style: TextStyle(color: Colors.white),),
          ],
        ),
        SizedBox(height: 20,)
      ],
    );
  }
}