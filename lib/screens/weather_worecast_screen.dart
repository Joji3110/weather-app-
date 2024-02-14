import 'package:flutter/material.dart';
import 'package:wether_example/screens/city_screen.dart';
import 'package:wether_example/widgets/bottom_list_view.dart';
import 'package:wether_example/widgets/city_view.dart';
import 'package:wether_example/widgets/detail.view.dart';
import 'package:wether_example/widgets/temp_view.dart';

import '../api/weather_api.dart';
import '../models/weather_worecast_daily.dart';


class WeatherForecastScreen extends StatefulWidget {
  final WeatherForecast? locationWeather;
  const WeatherForecastScreen({Key? key, this.locationWeather})
      : super(key: key);

  @override
  State<WeatherForecastScreen> createState() => _WeatherForecastScreenState();
}

class _WeatherForecastScreenState extends State<WeatherForecastScreen> {
  late Future<WeatherForecast> forecastObject;
  String? cityName;

  @override
  void initState() {
    super.initState();

    if (widget.locationWeather != null) {
      forecastObject = Future.value(widget.locationWeather);
    }

    forecastObject.then((weather) {
      print(weather.list![0].weather[0].main);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text('Погода'),
        foregroundColor: Colors.white,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          color: Colors.white,
          icon: const Icon(Icons.my_location),
          onPressed: () {
            setState(() {
              forecastObject = WeatherApi().fetchWeatherForecast();
            });
          },
        ),
        actions: [
          IconButton(
            color: Colors.white,
            icon: const Icon(Icons.location_city),
            onPressed: () async {
              var tappedName = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const CityScreen();
                  },
                ),
              );
              if (tappedName != null) {
                setState(() {
                  cityName = tappedName;
                  forecastObject = WeatherApi().fetchWeatherForecast(
                    cityName: cityName,
                    isCity: true,
                  );
                });
              }
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          Container(
            child: FutureBuilder<WeatherForecast>(
              future: forecastObject,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      const SizedBox(height: 50.0),
                      CityView(snapshot: snapshot),
                      const SizedBox(height: 50.0),
                      TempView(snapshot: snapshot),
                      const SizedBox(height: 50.0),
                      DetailView(snapshot: snapshot),
                      const SizedBox(height: 50),
                      BottomListView(snapshot: snapshot),
                    ],
                  );
                } else {
                  return const Center(
                    child: Text(
                      'Город не найден!\nПожалуйста, введите правильный город',
                      style: TextStyle(fontSize: 25),
                      textAlign: TextAlign.center,
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
