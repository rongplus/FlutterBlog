import 'package:flutter/material.dart';
//1
class TwoFacePainter extends CustomPainter {
  //2
  TwoFacePainter()
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
      Rect myRect = const Offset(240.0, 20.0) & const Size(500.0, 1000.0);
      canvas.drawRect(myRect, paint);

      double y = 80.0;

      canvas.drawLine( Offset(240.0, y),  Offset(740.0, y), paint);
      y+=80;
      canvas.drawLine( Offset(240.0, y),  Offset(740.0, y), paint);
      y+=80;
      canvas.drawLine( Offset(240.0, y),  Offset(740.0, y), paint);
      y+=80;
      canvas.drawLine( Offset(240.0, y),  Offset(740.0, y), paint);
      y+=80;
      canvas.drawLine( Offset(240.0, y),  Offset(740.0, y), paint);
      y+=80;
      canvas.drawLine( Offset(240.0, y),  Offset(740.0, y), paint);
      y+=80;
      canvas.drawLine( Offset(240.0, y),  Offset(740.0, y), paint);
      y+=80;
      canvas.drawLine( Offset(240.0, y),  Offset(740.0, y), paint);
      y+=80;
      canvas.drawLine( Offset(240.0, y),  Offset(740.0, y), paint);
      y+=80;
      canvas.drawLine( Offset(240.0, y),  Offset(740.0, y), paint);
      y+=80;
      canvas.drawLine( Offset(240.0, y),  Offset(740.0, y), paint);
      y+=80;
      canvas.drawLine( Offset(240.0, y),  Offset(740.0, y), paint);
      y+=80;
    }





  }

  //5
  @override
  bool shouldRepaint(TwoFacePainter oldDelegate) {
    return true;
  }
}
