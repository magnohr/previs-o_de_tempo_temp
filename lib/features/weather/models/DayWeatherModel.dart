import 'package:intl/intl.dart';

class DayWeatherModel {
  final DateTime date;
  final int maxTemp;
  final int minTemp;
  final String icon;
  final String main;
  final String description;

  DayWeatherModel({
    required this.date,
    required this.maxTemp,
    required this.minTemp,
    required this.main,
    required this.icon,
    required this.description,
  });

  factory DayWeatherModel.fromJson(Map<String, dynamic> json) {
    return DayWeatherModel(
      date: DateTime.parse(json['dt_txt']),
      maxTemp: json['main']['temp_max'].round(),
      minTemp: json['main']['temp_min'].round(),
      icon: json['weather'][0]['icon'],
      main: json['weather'][0]['main'],
      description: json['weather'][0]['description'],
    );
  }

  /// 📅 DIA FORMATADO (Mon, Tue, Wed...)
  /// ❌ SEM locale para evitar tela vermelha
  String get dayFormatted {
    const daysPt = {
      'Mon': 'Seg',
      'Tue': 'Ter',
      'Wed': 'Qua',
      'Thu': 'Qui',
      'Fri': 'Sex',
      'Sat': 'Sáb',
      'Sun': 'Dom',
    };

    final dayEn = DateFormat('EEE').format(date);
    return daysPt[dayEn] ?? dayEn;
  }
  /// 🌦️ ÍCONE DE ACORDO COM O CLIMA
  String get assetIcon {
    final m = main.toLowerCase();
    final d = description.toLowerCase();
    final isNight = icon.endsWith('n');

    // ⛈️ TEMPESTADE
    if (m == 'thunderstorm') {
      return 'assets/images/tempestade.png';
    }

    // 🌧️ CHUVA
    if (m == 'rain') {
      // 🌧️ CHUVA FORTE
      if (d.contains('heavy')) {
        return isNight
            ? 'assets/images/chuvaForteNoite.png'
            : 'assets/images/chuvaForteDia.png';
      }

      // 🌦️ CHUVA FRACA
      if (d.contains('light')) {
        return isNight
            ? 'assets/images/chuvaFracaNoite.png'
            : 'assets/images/chuvaFracaDia.png';
      }

      // 🌧️ CHUVA NORMAL
      return isNight
          ? 'assets/images/chuvaNoite.png'
          : 'assets/images/chuvaDia.png';
    }


    // 🌦️ GAROA
    if (m == 'drizzle') {
      return 'assets/images/garoa.png';
    }

    // ❄️ NEVE
    if (m == 'snow') {
      return 'assets/images/neve.png';
    }

    // 🌫️ NEBLINA / FUMAÇA
    if (m == 'mist' ||
        m == 'fog' ||
        m == 'haze' ||
        m == 'smoke' ||
        d.contains('mist') ||
        d.contains('fog') ||
        d.contains('haze') ||
        d.contains('smoke')) {
      return 'assets/images/nevoa.png';
    }

    // ☁️ NUVENS (PARTE MAIS IMPORTANTE)
    if (m == 'clouds') {
      if (d.contains('few')) {
        return isNight
            ? 'assets/images/luaNuvem.png'
            : 'assets/images/solNuvem.png';
      }

      if (d.contains('scattered')) {
        return 'assets/images/nuvemDispersa.png';
      }

      if (d.contains('broken')) {
        return 'assets/images/nuvemCarregada.png';
      }

      if (d.contains('overcast')) {
        return 'assets/images/nubladoTotal.png';
      }

      return 'assets/images/nubladoTotal.png';
    }

    // ☀️ CÉU LIMPO
    if (m == 'clear') {
      return isNight
          ? 'assets/images/lua.png'
          : 'assets/images/sun.png';
    }

    // 🔁 PADRÃO
    return 'assets/images/Cloud.png';
  }
}
