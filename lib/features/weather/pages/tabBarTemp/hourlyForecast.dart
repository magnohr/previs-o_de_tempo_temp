// hourlyforecast.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/weather.dart';

class Hourlyforecast extends StatefulWidget {
  const Hourlyforecast({super.key});

  @override
  State<Hourlyforecast> createState() => _HourlyforecastState();
}

class _HourlyforecastState extends State<Hourlyforecast> {

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<WeatherController>();
    final weather = controller.weather;
    final hours = weather?.hours ?? [];

    return SizedBox(
      height: 150,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: hours.map((hour) {
            return Padding(
              padding: const EdgeInsets.only(right: 12),
              child:Container(
                width: 60,
                height: 150,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: controller.bottomMenuGradient.colors
                        .map((c) => c.withOpacity(0.35)) // 👈 AJUSTE DE COR
                        .toList(),
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    Text(
                      hour.hourFormatted,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 40,
                      width: 40,
                      child: Image.asset(
                        hour.assetIcon,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${hour.temperature}°',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      hour.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 7,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
