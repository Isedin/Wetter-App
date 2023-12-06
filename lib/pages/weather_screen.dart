import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_wetter_application_1/additional_info_item.dart';
import 'package:flutter_wetter_application_1/hourly_forecast_item.dart';
import 'package:http/http.dart' as http;
import '../geheim.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  // double temp = 0;
  // bool isLoading = false;

  // @override
  // void initState() {
  //   super.initState();
  //   try {
  //     getCurrentWeather();
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      // setState(() {
      //   isLoading = true;
      // });
      String cityName = 'Kassel';
      final res = await http.get(
        Uri.parse(
            'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$openWeatherAPIKey'),
      );

      final data = jsonDecode(res.body);

      if (data['cod'] != '200') {
        throw 'An unexpected error occured!'; // Znaci throw nam ovdje izbacuje gresku ukoliko cod nije 200 tj. ukoliko je greska!!!
      }
// if(int.parse(data['cod'])!= 200); we can do on this way as well!!
      // if(res.statusCode == 200); or this way
      return data;
      // setState(() {
      // temp =
      // data['list'][0]['main']['temp'];
      // isLoading = false;
      // });
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Scaffold eigenschaften beeinflussen nur ein Page, während "theme " beeinflusst ganze App
      // backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        title: const Text(
          'Weather app',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body:
          //temp == 0 ? const CircularProgressIndicator() :
          FutureBuilder(
        future: getCurrentWeather(),
        builder: (context, snapshot) {
          print(
              snapshot); // snapshot is a class that allows you to handle states in the app
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator
                  .adaptive(), // adaptive sets the "CircularProgressIndicator" to look depende on what os is. Android or iOS
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          // if(snapshot.hasData!=null) {

          // }

          final data = snapshot.data!;

final currentWeatherData = data['list'][0];

          final currentTemp = currentWeatherData['main']['temp'];
          final currentSky = currentWeatherData['weather'][0]['main'];
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //main card
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 10,
                        sigmaY: 10,
                      ),
                      child: Container(
                        decoration: const BoxDecoration(),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              Text(
                                '$currentTemp K',
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 18,
                              ),
                              const Icon(
                                Icons.cloud,
                                size: 65,
                                color: Colors.blueGrey,
                              ),
                              SizedBox(height: 16),
                              Text(
                                currentSky,
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // Placeholder(
                //   fallbackHeight: 250,
                // ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: const Text(
                    'Weather Forecast',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      HourlyForecastItem(
                        time: '00:00',
                        icon: Icons.cloud,
                        temperature: '15°C',
                      ),
                      HourlyForecastItem(
                        time: '01:00',
                        icon: Icons.sunny,
                        temperature: '35°C',
                      ),
                      HourlyForecastItem(
                        time: '02:00',
                        icon: Icons.sunny,
                        temperature: '30°C',
                      ),
                      HourlyForecastItem(
                        time: '03:00',
                        icon: Icons.sunny,
                        temperature: '31°C',
                      ),
                      HourlyForecastItem(
                        time: '04:00',
                        icon: Icons.cloud,
                        temperature: '20°C',
                      ),
                      HourlyForecastItem(
                        time: '05:00',
                        icon: Icons.sunny,
                        temperature: '35°C',
                      ),
                      HourlyForecastItem(
                        time: '06:00',
                        icon: Icons.sunny,
                        temperature: '30°C',
                      ),
                      HourlyForecastItem(
                        time: '07:00',
                        icon: Icons.cloud,
                        temperature: '21°C',
                      ),
                      HourlyForecastItem(
                        time: '08:00',
                        icon: Icons.sunny,
                        temperature: '33°C',
                      ),
                      HourlyForecastItem(
                        time: '09:00',
                        icon: Icons.cloud,
                        temperature: '19°C',
                      ),
                    ],
                  ),
                ),
                //Weather forecast cards
                // Placeholder(
                //   fallbackHeight: 130,
                // ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Additional information',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 9,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceAround, //der Vorteil von MainAxisAlignment ist das, dass wir nicht für jedes Element separate Padding machen müssen
                  children: [
                    AdditionalInfoItem(
                      icon: Icons.water_drop,
                      label: 'Humidity',
                      value: '91',
                    ),
                    AdditionalInfoItem(
                      icon: Icons.air,
                      label: 'Wind Speed',
                      value: '7.5',
                    ),
                    AdditionalInfoItem(
                      icon: Icons.beach_access,
                      label: 'Pressure',
                      value: '1000',
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
