// Converte JSON em Map/List
import 'dart:convert';

// Base do Flutter + ChangeNotifier
import 'package:flutter/material.dart';

// Biblioteca HTTP para chamadas de API
import 'package:http/http.dart' as http;

// Theme e Models
import '../../../core/theme/theme_data.dart';
import '../models/DayWeatherModel.dart';
import '../models/HourWeatherModel.dart';
import '../models/weatherModel.dart';

/// 🎯 Controller responsável por:
/// - Buscar dados do clima
/// - Controlar estado (loading / erro)
/// - Definir temas, cores e imagens
/// - Permitir refresh via FAB
class WeatherController extends ChangeNotifier {

  /// 🔑 API KEY
  final String apiKey = '0c18c3d08005f807e172f809875e601a';

  /// 🌦️ Modelo principal
  WeatherModel? weather;

  /// ⏳ Estado de carregamento
  bool isLoading = false;

  /// ❌ Mensagem de erro
  String? error;

  /// 📍 Última localização (para refresh)
  double? _lastLat;
  double? _lastLon;

  // ================================
  // 🌤️ CLIMA ATUAL POR LOCALIZAÇÃO
  // ================================
  Future<void> fetchWeatherByLocation(double lat, double lon) async {
    _lastLat = lat;
    _lastLon = lon;

    try {
      isLoading = true;
      error = null;
      notifyListeners();

      final currentUrl = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather'
            '?lat=$lat&lon=$lon&appid=$apiKey&units=metric&lang=pt_br',
      );

      final response = await http.get(currentUrl);

      if (response.statusCode != 200) {
        throw Exception('Erro HTTP ${response.statusCode}');
      }

      final data = jsonDecode(response.body);

      weather = WeatherModel(
        city: data['name'],
        temperature: data['main']['temp'].round(),
        description: data['weather'][0]['description'],
        maxTemp: data['main']['temp_max'].round(),
        minTemp: data['main']['temp_min'].round(),
        houseImage: 'assets/images/house.png',
        hours: [],
        days: [],
      );

      await fetchHourlyForecast(lat, lon);
      await fetchDailyForecast(lat, lon);

    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // ================================
  // 🔄 REFRESH (FAB)
  // ================================
  Future<void> refreshWeather() async {
    if (_lastLat != null && _lastLon != null && !isLoading) {
      await fetchWeatherByLocation(_lastLat!, _lastLon!);
    }
  }

  // ================================
  // 🖼️ BACKGROUND POR HORÁRIO
  // ================================
  String get backgroundImage {
    final hour = DateTime.now().hour;

    if (hour >= 6 && hour < 16) {
      return 'assets/images/ceuu.jpg';
    } else if (hour >= 16 && hour < 18) {
      return 'assets/images/tarde1.png';
    } else {
      return 'assets/images/roxo.webp';
    }
  }

  // ================================
  // 🏠 / 🚤 CASA OU BARCO
  // ================================
  String get houseOrBoatImage {
    final hour = DateTime.now().hour;

    if (hour >= 16 && hour < 18) {
      return 'assets/images/barco.png';
    }

    return 'assets/images/house.png';
  }

  // ================================
  // 🎨 GRADIENTE DO MENU INFERIOR
  // ================================
  LinearGradient get bottomMenuGradient {
    final hour = DateTime.now().hour;

    if (hour >= 6 && hour < 16) {
      return AppTheme.dayBottomGradient;
    }

    if (hour >= 16 && hour < 18) {
      return AppTheme.afternoonBottomGradient;
    }

    return AppTheme.nightBottomGradient;
  }

  // ================================
  // 🧭 GRADIENTE DO DRAWER
  // ================================
  LinearGradient get navigationGradient {
    final hour = DateTime.now().hour;

    if (hour >= 6 && hour < 16) {
      return AppTheme.dayNavigationGradient;
    }

    if (hour >= 16 && hour < 18) {
      return AppTheme.afternoonNavigationGradient;
    }

    return AppTheme.nightNavigationGradient;
  }

  // ================================
  // 🏙️ COR DO TEXTO DA CIDADE
  // ================================
  Color get cityTextColor {
    final hour = DateTime.now().hour;

    if (hour >= 6 && hour < 18) {
      return const Color(0xFF1F1B3A);
    }

    return Colors.white;
  }

  // ================================
  // 🔍 BUSCA POR CIDADE
  // ================================
  Future<Map<String, dynamic>> fetchCityWeather(String cityName) async {
    final url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather'
          '?q=$cityName&appid=$apiKey&units=metric&lang=pt_br',
    );

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Cidade não encontrada');
    }

    final data = jsonDecode(response.body);
    final main = data['weather'][0]['main'].toString().toLowerCase();

    IconData icon = Icons.cloud_queue;
    if (main.contains('rain')) icon = Icons.umbrella;
    if (main.contains('cloud')) icon = Icons.cloud;
    if (main.contains('clear')) icon = Icons.wb_sunny;
    if (main.contains('storm')) icon = Icons.thunderstorm;

    return {
      'city': data['name'],
      'description': data['weather'][0]['description'],
      'temperature': data['main']['temp'].round(),
      'maxTemp': data['main']['temp_max'].round(),
      'minTemp': data['main']['temp_min'].round(),
      'icon': icon,
    };
  }

  // ================================
  // 📅 PREVISÃO DIÁRIA
  // ================================
  Future<void> fetchDailyForecast(double lat, double lon) async {
    try {
      final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast'
            '?lat=$lat&lon=$lon&appid=$apiKey&units=metric&lang=pt_br',
      );

      final response = await http.get(url);

      if (response.statusCode != 200) {
        throw Exception('Erro HTTP ${response.statusCode}');
      }

      final data = jsonDecode(response.body);

      weather!.days = (data['list'] as List)
          .where((e) => e['dt_txt'].contains('12:00:00'))
          .map((e) => DayWeatherModel.fromJson(e))
          .toList();

      notifyListeners();
    } catch (e) {
      error = e.toString();
      notifyListeners();
    }
  }

  // ================================
  // ⏰ PREVISÃO POR HORA
  // ================================
  Future<void> fetchHourlyForecast(double lat, double lon) async {
    try {
      final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast'
            '?lat=$lat&lon=$lon&appid=$apiKey&units=metric&lang=pt_br',
      );

      final response = await http.get(url);

      if (response.statusCode != 200) {
        throw Exception('Erro HTTP ${response.statusCode}');
      }

      final data = jsonDecode(response.body);

      weather!.hours = (data['list'] as List)
          .take(8)
          .map((e) => HourWeatherModel.fromJson(e))
          .toList();

      notifyListeners();
    } catch (e) {
      error = e.toString();
      notifyListeners();
    }
  }

  // ================================
  // ❌ ERRO MANUAL
  // ================================
  void setError(String message) {
    error = message;
    isLoading = false;
    notifyListeners();
  }
}
