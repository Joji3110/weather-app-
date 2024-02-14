import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import 'package:wether_example/models/weather_worecast_daily.dart';
import 'package:wether_example/utils/constants.dart';
import 'package:wether_example/utils/location.dart';

class WeatherApi {
  Future<WeatherForecast> fetchWeatherForecast( {String? cityName, bool? isCity}) async {
    Location location = Location();
    await location.getCurrentLocation();

    Map<String, String?> parametrs;

    if (isCity == true) {
      var params = {
        'appid': Constants.WEATHER_APP_ID,
        'units': 'metric',
        'q': cityName,
        'lang': 'ru',
      };
      parametrs = params;
    } else {
         var params = {
        'appid': Constants.WEATHER_APP_ID,
        'units': 'metric',
        'lat': location.latidue.toString(),
        'lon': location.longidue.toString(),
        'lang': 'ru',
      };
      parametrs = params;
    }

    var uri = Uri.https(Constants.WEATHER_BASE_URL_DOMAIN,
        Constants.WEATHER_FORECAST_PATH, parametrs);

    log('result: ${uri.toString()}');

    var response = await http.get(uri);

    print('responce: ${response.body}');

    if (response.statusCode == 200) {
      return WeatherForecast.fromJson(json.decode(response.body));
    } else {
      return Future.error('Error responce');
    }
  }
}
