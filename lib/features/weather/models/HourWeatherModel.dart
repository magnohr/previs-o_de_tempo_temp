class HourWeatherModel {
  final DateTime time;
  final int temperature;
  final String icon;
  final String main;
  final String description;

  HourWeatherModel({
    required this.time,
    required this.temperature,
    required this.icon,
    required this.main,
    required this.description,
  });

  factory HourWeatherModel.fromJson(Map<String, dynamic> json) {
    return HourWeatherModel(
      time: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
      temperature: json['main']['temp'].round(),
      icon: json['weather'][0]['icon'],
      main: json['weather'][0]['main'],
      description: json['weather'][0]['description'],
    );
  }

  // 🕒 HORA FORMATADA
  String get hourFormatted =>
      '${time.hour.toString().padLeft(2, '0')}h';

  // 🌦️ ÍCONE DE ACORDO COM A PREVISÃO
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
      if (d.contains('heavy') || d.contains('forte')) {
        return isNight
            ? 'assets/images/chuvaForteNoite.png'
            : 'assets/images/chuvaForteDia.png';
      }

      if (d.contains('light') || d.contains('fraca')) {
        return isNight
            ? 'assets/images/chuvaFracaNoite.png'
            : 'assets/images/chuvaFracaDia.png';
      }

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
        d.contains('smoke') ||
        d.contains('nevoa')) {
      return 'assets/images/nevoa.png';
    }

    // ☁️ NUVENS
    if (m == 'clouds') {
      // ☀️🌙 poucas nuvens
      if (d.contains('few') || d.contains('poucas')) {
        return isNight
            ? 'assets/images/luaNuvem.png'
            : 'assets/images/solNuvem.png';
      }

      // ☁️ nuvens dispersas
      if (d.contains('scattered') || d.contains('dispers')) {
        return 'assets/images/nuvemDispersa.png';
      }

      // ☁️☁️ nuvens quebradas / carregadas
      if (d.contains('broken') || d.contains('quebradas')) {
        return 'assets/images/nuvemCarregada.png';
      }

      // ☁️☁️☁️ totalmente nublado
      if (d.contains('overcast') || d.contains('nublado')) {
        return 'assets/images/nubladoTotal.png';
      }

      // fallback seguro
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
