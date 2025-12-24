import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/weather.dart';

class WeatherDetailsScreen extends StatelessWidget {
  const WeatherDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<WeatherController>();
    final weather = controller.weather;

    if (weather == null) {
      return const Scaffold(
        backgroundColor: Color(0xFF1F1B3A),
        body: Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      );
    }

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
                  const Text(
                    'Weather Details',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // 🌫️ AIR QUALITY (exemplo visual)
              _card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('AIR QUALITY', style: _labelStyle),
                    SizedBox(height: 8),
                    Text('3 – Low Health Risk', style: _valueStyle),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // 📊 GRID DE DADOS REAIS
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1.2,
                  children: [
                    _InfoCard(
                      title: 'TEMPERATURE',
                      main: '${weather.temperature}°C',
                      sub: 'Current',
                    ),
                    _InfoCard(
                      title: 'MAX TEMP',
                      main: '${weather.maxTemp}°C',
                      sub: 'Today',
                    ),
                    _InfoCard(
                      title: 'MIN TEMP',
                      main: '${weather.minTemp}°C',
                      sub: 'Today',
                    ),
                    _InfoCard(
                      title: 'CONDITION',
                      main: weather.description,
                      sub: weather.city,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _card({required Widget child}) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFF2E2A5D),
      borderRadius: BorderRadius.circular(20),
    ),
    child: child,
  );
}

class _InfoCard extends StatelessWidget {
  final String title;
  final String main;
  final String sub;

  const _InfoCard({
    required this.title,
    required this.main,
    required this.sub,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2E2A5D),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: _labelStyle),
          Text(main, style: _valueStyle),
          Text(sub, style: _subStyle),
        ],
      ),
    );
  }
}

const _labelStyle = TextStyle(
  color: Colors.white70,
  fontSize: 12,
  fontWeight: FontWeight.w600,
);

const _valueStyle = TextStyle(
  color: Colors.white,
  fontSize: 18,
  fontWeight: FontWeight.bold,
);

const _subStyle = TextStyle(
  color: Colors.white54,
  fontSize: 12,
);
