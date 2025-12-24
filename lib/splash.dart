import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late String splashImage;

  @override
  void initState() {
    super.initState();

    splashImage = _getSplashImage();

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  String _getSplashImage() {
    final hour = DateTime.now().hour;

    if (hour >= 6 && hour < 16) {
      return 'assets/images/ceuu.jpg';
    } else if (hour >= 16 && hour < 18) {
      return 'assets/images/tarde1.png';
    } else {
      return 'assets/images/roxo.webp';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Image.asset(
          splashImage,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
