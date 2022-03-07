import 'package:flutter/material.dart';

class MyPainter extends CustomPainter {
  Function(String)? setState;
  ValueChanged<Offset>? expand;
  final BuildContext context;
  double textSize;

  MyPainter({
    required this.context,
    this.setState,
    this.expand,
    required this.textSize,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // var borderRectPaint = Paint()
    //   ..color = Colors.red
    //   ..strokeWidth = 2
    //   ..style = PaintingStyle.stroke;
    //
    // var circlePaint = Paint()
    //   ..color = Colors.blue
    //   ..strokeWidth = 2
    //   ..style = PaintingStyle.fill
    //   ..strokeCap = StrokeCap.round;
    //
    // var borderRect = Rect.fromPoints(leftTopOffset, rightBottomOffset);
    //
    // final textStyle = TextStyle(
    //   color: Colors.black,
    //   fontSize: (rightTopOffset.dx - leftTopOffset.dx) / 7,
    // );
    final textStyle = TextStyle(
      color: Colors.black,
      fontSize: textSize,
    );
    final textSpan = TextSpan(
      text: 'Hello, world.',
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    final xCenter = (size.width - textPainter.width) / 2;
    final yCenter = (size.height - textPainter.height) / 2;
    final offset = Offset(xCenter, yCenter);

    // canvas.save();
    // canvas.scale(1.4);

    textPainter.paint(canvas, offset / 1.4);
    // canvas.restore();
  }

  void rotate(Canvas canvas, double cx, double cy, double angleRadians) {
    canvas.translate(cx, cy);
    canvas.rotate(angleRadians);
    canvas.translate(-cx, -cy);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
