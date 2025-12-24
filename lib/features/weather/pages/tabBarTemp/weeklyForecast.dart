import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/weather.dart';

class Weeklyforecast extends StatelessWidget {
  const Weeklyforecast({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<WeatherController>();
    final days = controller.weather?.days ?? [];

    if (controller.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (days.isEmpty) {
      return const Center(
        child: Text(
          'Sem previsão semanal',
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    return SizedBox(
      height: 350,
      child: ListView.builder(
        itemCount: days.length,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        itemBuilder: (context, index) {
          final day = days[index];

          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  day.dayFormatted,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 35,
                  width: 35,
                  child: Image.asset(day.assetIcon),
                ),
                Row(
                  children: [
                    Text(
                      '${day.maxTemp}°  ',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${day.minTemp}°',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 16,
                      ),
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
