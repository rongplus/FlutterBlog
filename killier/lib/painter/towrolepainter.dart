import 'package:flutter/material.dart';
//1
class TwoRolePainter extends CustomPainter {
  //2
  TwoRolePainter()
  {

  }

  //3
  Color color = Colors.white24;

  //4
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.green[800]!;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 2.0;

    {
      double x = 10.0;
      Rect myRect = const Offset(10, 10.0) & const Size(580.0, 1000.0);
      canvas.drawRect(myRect, paint);

      double y = 65.0;
      double h = 65;

      canvas.drawLine( Offset(x, y),  Offset(590, y), paint);
      y+=h;
      canvas.drawLine( Offset(x, y),  Offset(590, y), paint);
      y+=h;
      canvas.drawLine( Offset(x, y),  Offset(590, y), paint);
      y+=h;
      canvas.drawLine( Offset(x, y),  Offset(590, y), paint);
      y+=h;
      canvas.drawLine( Offset(x, y),  Offset(590, y), paint);
      y+=h;
      canvas.drawLine( Offset(x, y),  Offset(590, y), paint);
      y+=h;
      canvas.drawLine( Offset(x, y),  Offset(590, y), paint);
      y+=h;
      canvas.drawLine( Offset(x, y),  Offset(590, y), paint);
      y+=h;
      canvas.drawLine( Offset(x, y),  Offset(590, y), paint);
      y+=h;
      canvas.drawLine( Offset(x, y),  Offset(590, y), paint);
      y+=h;
      canvas.drawLine( Offset(x, y),  Offset(590, y), paint);
      y+=h;
      canvas.drawLine( Offset(x, y),  Offset(590, y), paint);
      y+=h;
      canvas.drawLine( Offset(x, y),  Offset(590, y), paint);
      y+=h;
      canvas.drawLine( Offset(x, y),  Offset(590, y), paint);
      y+=h;
      canvas.drawLine( Offset(x, y),  Offset(590, y), paint);
      y+=h;
      canvas.drawLine( Offset(x, y),  Offset(590, y), paint);
      y+=h;
      canvas.drawLine( Offset(x, y),  Offset(590, y), paint);
      y+=h;
      canvas.drawLine( Offset(x, y),  Offset(590, y), paint);
      y+=h; canvas.drawLine( Offset(x, y),  Offset(590, y), paint);
      y+=h;

    }





  }

  //5
  @override
  bool shouldRepaint(TwoRolePainter oldDelegate) {
    return true;
  }
}
