import 'package:flutter/material.dart';
import 'package:insta_copy/App.dart';
import 'package:insta_copy/createBody.dart';
import 'package:insta_copy/createBottom.dart';
import 'package:insta_copy/createHeader.dart';
import 'package:insta_copy/videoContent.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: App(),
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