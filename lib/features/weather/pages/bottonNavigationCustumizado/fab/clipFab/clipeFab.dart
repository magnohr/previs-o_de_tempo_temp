import 'package:flutter/material.dart';

class TopWaveUpClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    // canto superior esquerdo
    path.moveTo(0, 0);

    // desce até antes da onda
    path.lineTo(0, 40);

    // curva sobe no centro (onda pra cima)
    path.quadraticBezierTo(
      size.width / 2,
      -40, // 🔥 sobe pra fora do container
      size.width,
      40,
    );

    // resto do container
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
