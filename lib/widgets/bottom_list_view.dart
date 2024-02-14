import 'package:flutter/material.dart';
import 'package:wether_example/models/weather_worecast_daily.dart';
import 'package:wether_example/widgets/forecast_card.dart';

class BottomListView extends StatelessWidget {
  final AsyncSnapshot<WeatherForecast> snapshot;
  const BottomListView({Key? key, required this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Прогноз на 7 дней',
          style: TextStyle(
              fontSize: 20.0,
              color: Colors.black87,
              fontWeight: FontWeight.bold),
        ),
        Container(
          height: 150,
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => const SizedBox(width: 8.0),
            itemCount: snapshot.data!.list!.length,
            itemBuilder: (context, index) => Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: Colors.black87,
              ),
              width: MediaQuery.of(context).size.width / 2.7,
              height: 160,
              child: forecastCard(snapshot, index),
            ),
          ),
        ),
      ],
    );
  }
}
