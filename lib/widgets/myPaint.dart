import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyPaint extends CustomPainter{
  final double compPercent;
  final double borderWidth;
  final double outCircleRadius;
  final double inCircleRadius;

  MyPaint(this.compPercent, this.borderWidth, this.outCircleRadius, this.inCircleRadius);

  @override
  void paint(Canvas canvas, Size size) {
    double borderHeight = 5;

    Paint paint = Paint()
    ..color = Colors.black12;
    Paint paint2 = Paint()
    ..color = Colors.orange;
    
    Paint paint3 = Paint()
    ..color = Colors.white;
    
    double startPointx = size.width/2 -(borderWidth/2);

    Offset p1 = new Offset(size.width/2,size.height/2);
    Offset circleCenter = new Offset(startPointx+compPercent, size.height/2);
    

    Rect borderRect= Rect.fromCenter(center:p1,width:borderWidth,height:borderHeight); 
    // Rect borderCompRect = Rect.fromLTWH(-(borderWidth/2),-(borderHeight/2) , compPercent, borderHeight);
    Rect borderCompRect = Rect.fromLTWH(startPointx,size.height/2 - (borderHeight/2) , compPercent, borderHeight);
    
    RRect border = RRect.fromRectAndRadius(borderRect,Radius.circular(16));
    RRect borderComp = RRect.fromRectAndRadius(borderCompRect,Radius.circular(16));


    canvas.drawRRect(border, paint);

    canvas.drawRRect(borderComp, paint2);

    canvas.drawCircle(circleCenter, outCircleRadius, paint2);

    canvas.drawCircle(circleCenter, inCircleRadius , paint3);

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }

}