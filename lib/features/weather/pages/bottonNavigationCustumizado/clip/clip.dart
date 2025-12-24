import 'package:flutter/cupertino.dart';

class TopWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.lineTo(0, 20);

    // 🔥 curva pra cima
    path.quadraticBezierTo(
      size.width / 2,
      100, // quanto mais negativo, mais sobe
      size.width,
      20,
    );

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
