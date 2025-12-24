import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/weather.dart';
import '../bottonNavigationCustumizado/clip/clip.dart';
import '../tabBarTemp/hourlyForecast.dart';
import '../tabBarTemp/weeklyForecast.dart' hide Hourlyforecast;

class Bottonbar extends StatelessWidget {
  final ScrollController scrollController;

  const Bottonbar({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<WeatherController>(); // 👈 ADICIONADO

    return DefaultTabController(
      length: 2,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
        child: Container(
          height: 350,
          decoration: BoxDecoration( // 👈 TIRADO O const
            gradient: controller.navigationGradient, // 👈 APLICADO
          ),

          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                const SizedBox(height: 10),

                // 🔵 Barra de arrasto (handle)
                Container(
                  width: 40,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                const SizedBox(height: 10),

                const TabBar(
                  indicatorColor: Colors.white,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white60,
                  tabs: [
                    Tab(text: "Previsão por horário"),
                    Tab(text: "Previsão Semanal"),
                  ],
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.20,
                  child: const TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      Hourlyforecast(),
                      Weeklyforecast(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
