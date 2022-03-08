import 'package:flutter/material.dart';

class MyPainter extends CustomPainter {
  Function(String)? setState;
  ValueChanged<Offset>? expand;
  final BuildContext context;
  final Offset startOffset;
  final Offset translate;
  final double scaleFactor;
  final double rotateAngle;
  double textSize;

  MyPainter({
    required this.context,
    this.setState,
    this.expand,
    required this.startOffset,
    required this.translate,
    required this.rotateAngle,
    required this.textSize,
    required this.scaleFactor,
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
      text: 'Hello, world',
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
    final xCenter = size.width / 2;
    final yCenter = size.height / 2;

    canvas.translate(translate.dx, translate.dy);
    scaleWithCenter(canvas, xCenter, yCenter, scaleFactor);
    rotateWithCenter(canvas, xCenter, yCenter, rotateAngle);

    textPainter.paint(canvas, startOffset);
    // canvas.restore();
  }

  void rotateWithCenter(
      Canvas canvas, double cx, double cy, double angleRadians) {
    canvas.translate(cx, cy);
    canvas.rotate(angleRadians);
    canvas.translate(-cx, -cy);
  }

  void scaleWithCenter(Canvas canvas, double cx, double cy, double scale) {
    canvas.translate(cx, cy);
    canvas.scale(scale);
    canvas.translate(-cx, -cy);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
