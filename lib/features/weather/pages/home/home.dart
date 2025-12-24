import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/weather.dart';

import '../../services/geolocalizacao/geo.dart';
import '../buttonBar/bottonBar.dart';
import '../bottonNavigationCustumizado/bottonNavigationCustumizado.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {



  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      final controller = context.read<WeatherController>();

      try {
        final position = await LocationService.getCurrentPosition();

        await controller.fetchWeatherByLocation(
          position.latitude,
          position.longitude,
        );



      } catch (e) {
        controller.setError('Não foi possível acessar sua localização');
      }
    });
  }



/*

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<WeatherController>()
          .fetchWeatherByLocation(47.6062, -122.3321);
    });
  }

 */






  @override
  Widget build(BuildContext context) {
    final controller = context.watch<WeatherController>();

    // ⏳ LOADING
    // 🔄 LOADING
    if (controller.isLoading) {
      return const Scaffold(
        backgroundColor: Color(0xFF1F1B3A), // roxo padrão
        body: Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      );
    }

// ❌ ERRO
    if (controller.error != null) {
      return Scaffold(
        backgroundColor: const Color(0xFF1F1B3A),
        body: Center(
          child: Text(
            controller.error!,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

// ❗ WEATHER NULO (segurança)
    final weather = controller.weather;

    if (weather == null) {
      return const Scaffold(
        backgroundColor: Color(0xFF1F1B3A),
        body: Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      );
    }



    // ✅ DADOS CARREGADOS
    return Scaffold(
      body: Stack(
        children: [

          // 🖼️ FUNDO
          Positioned.fill(
            child: Image.asset(
              controller.backgroundImage,
              fit: BoxFit.cover,
            ),
          ),

          // 📄 CONTEÚDO
          Positioned.fill(
            child: Column(
              children: [
                const SizedBox(height: 80),

                Text(
                  weather.city,
                  style: TextStyle(
                    fontSize: 32,
                    color: controller.cityTextColor,
                    fontWeight: FontWeight.w300,
                  ),
                ),

                Text(
                  '${weather.temperature}°',
                  style: TextStyle(
                    fontSize: 140,
                    color: controller.cityTextColor,
                    fontWeight: FontWeight.w200,
                  ),
                ),

                Text(
                  weather.description,
                  style: TextStyle(
                    fontSize: 18,
                    color: controller.cityTextColor,
                  ),
                ),

                const SizedBox(height: 8),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'H:${weather.maxTemp}°',
                      style: TextStyle(
                        fontSize: 20, // ⬅️ aumentei um pouco
                        color: controller.cityTextColor,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Text(
                      'L:${weather.minTemp}°',
                      style: TextStyle(
                        fontSize: 18, // ⬅️ mesmo tamanho
                        color: controller.cityTextColor,
                      ),
                    ),
                  ],
                ),


                const SizedBox(height: 10),
                if (controller.houseOrBoatImage != null)
                  Transform.scale(
                    scale: controller.houseOrBoatImage!.contains('barco') ? 0.9 : 1.0,
                    child: Image.asset(
                      controller.houseOrBoatImage!,
                      width: 430,
                      height: 485,
                    ),
                  ),
              ],
            ),
          ),

          // 🔽 BOTTOM SHEET
          Positioned.fill(
            child: DraggableScrollableSheet(
              initialChildSize: 0.19,
              minChildSize: 0.18,
              maxChildSize: 0.39,
              snap: true,
              snapSizes: const [0.28, 0.39],
              builder: (context, scrollController) {
                return Bottonbar(scrollController: scrollController);
              },
            ),
          ),

          // 🧭 MENU
          const Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: CustomBottomMenu(),
          ),
        ],
      ),
    );
  }
}
