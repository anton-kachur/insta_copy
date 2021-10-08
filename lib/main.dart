import 'package:flutter/material.dart';
import 'package:insta_copy/createBody.dart';
import 'package:insta_copy/createBottom.dart';
import 'package:insta_copy/createHeader.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: createHeader().runAppBar(),
      body: Body(),
      bottomNavigationBar: Bottom(),
    )
  )
  );
}


class Painter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p1 = Offset(2, 120);
    final p2 = Offset(1000, 120);
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 4;
    canvas.drawLine(p1, p2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter old) => false;
}