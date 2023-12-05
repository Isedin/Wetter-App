import 'package:flutter/material.dart';


class HourlyForecastItem extends StatelessWidget {
  final String time;
  final String temperature;
  final IconData icon;
  const HourlyForecastItem({
    super.key,
    required this.time,
    required this.temperature,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Text(
              time,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 9,
            ),
            Icon(
              icon,
              size: 33,
              color: Colors.lightBlue,
            ),
            const SizedBox(
              height: 9,
            ),
            Text(
              temperature,
              // style: TextStyle(
              //   fontSize: 16,
              //   fontWeight: FontWeight.bold,
              // ),
            ),
          ],
        ),
      ),
    );
  }
}