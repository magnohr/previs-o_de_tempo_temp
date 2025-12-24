import 'package:flutter/material.dart';
import '../../controller/weather.dart';
import 'modelCidade.dart';

class WeatherWidgetsScreen extends StatefulWidget {
  const WeatherWidgetsScreen({super.key});

  @override
  State<WeatherWidgetsScreen> createState() => _WeatherWidgetsScreenState();
}

class _WeatherWidgetsScreenState extends State<WeatherWidgetsScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<WeatherCard> _citiesFromApi = [];

  bool isLoading = false;
  String? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1F1B3A),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔙 HEADER
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Buscar cidade',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // 🔍 PESQUISA
              TextField(
                controller: _searchController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Digite o nome da cidade',
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
                  prefixIcon: const Icon(Icons.search, color: Colors.white),
                  filled: true,
                  fillColor: const Color(0xFF2A2558),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
                onSubmitted: (cityName) async {
                  if (cityName.isEmpty) return;

                  try {
                    setState(() {
                      isLoading = true;
                      error = null;
                    });

                    final controller = WeatherController();
                    final data =
                    await controller.fetchCityWeather(cityName);

                    setState(() {
                      _citiesFromApi.insert(
                        0,
                        WeatherCard(
                          city: data['city'],
                          description: data['description'],
                          temperature: data['temperature'],
                          maxTemp: data['maxTemp'],
                          minTemp: data['minTemp'],
                          icon: data['icon'],
                        ),
                      );
                    });
                  } catch (e) {
                    setState(() {
                      error = 'Cidade não encontrada';
                    });
                  } finally {
                    setState(() {
                      isLoading = false;
                    });
                  }
                },
              ),

              const SizedBox(height: 16),

              // 📜 RESULTADOS
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: Colors.deepPurpleAccent,
                      width: 2,
                    ),
                  ),
                  child: isLoading
                      ? const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  )
                      : error != null
                      ? Center(
                    child: Text(
                      error!,
                      style:
                      const TextStyle(color: Colors.white70),
                    ),
                  )
                      : _citiesFromApi.isEmpty
                      ? const Center(
                    child: Text(
                      'Busque uma cidade',
                      style: TextStyle(color: Colors.white70),
                    ),
                  )
                      : ListView(children: _citiesFromApi),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
