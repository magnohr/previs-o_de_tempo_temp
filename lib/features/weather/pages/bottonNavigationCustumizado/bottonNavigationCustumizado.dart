import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/weather.dart';
import '../cidades/cidades.dart';
import '../configuracoes/configuracoes.dart';
import 'clip/clip.dart';

class CustomBottomMenu extends StatelessWidget {
  const CustomBottomMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<WeatherController>(); // 👈 ADICIONADO

    return SizedBox(
      height: 250,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [

          // 🔵 FUNDO CURVADO (atrás)
          Positioned(
            bottom: 0,
            child: ClipPath(
              clipper: TopWaveClipper(),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 120,
                decoration: BoxDecoration( // 👈 CORRIGIDO
                  gradient: controller.bottomMenuGradient,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.place_outlined,
                        color: Colors.white,
                        size: 28,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const WeatherWidgetsScreen(),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.menu,
                        color: Colors.white,
                        size: 28,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const WeatherDetailsScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ⚪ FAB CENTRAL
          Positioned(
            bottom: 20,
            child: GestureDetector(
              onTap: () {
                final controller = context.read<WeatherController>();

                if (!controller.isLoading) {
                  controller.refreshWeather();
                }
              },
              child: Container(
                height: 72,
                width: 72,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: controller.bottomMenuGradient,
                ),
                child: Center(
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: controller.isLoading
                        ? const Padding(
                      padding: EdgeInsets.all(12),
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        color: Color(0xFF3D2E8E),
                      ),
                    )
                        : const Icon(
                      Icons.refresh,
                      size: 28,
                      color: Color(0xFF3D2E8E),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // 🔵 CAMADA DA FRENTE (onda por cima do FAB)
          Positioned(
            bottom: 78,
            child: ClipPath(
              clipper: TopWaveClipper(),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration( // 👈 GRADIENTE DINÂMICO
                  gradient: controller.bottomMenuGradient,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
