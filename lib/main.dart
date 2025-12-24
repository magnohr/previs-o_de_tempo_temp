import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/weather/controller/weather.dart';
import 'splash.dart';
import 'features/weather/pages/home/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {


    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => WeatherController(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Temp',

        initialRoute: '/',

        routes: {
          '/': (context) =>  SplashScreen(),
          '/home': (context) => const Home(),
        },
      ),
    );
  }
}
