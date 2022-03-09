import 'dart:math';

import 'package:flutter/material.dart';

class MyPainter extends CustomPainter {
  Function(String)? setState;
  ValueChanged<Offset>? expand;
  final BuildContext context;
  double textSize;
  double angle;
  final Offset? currentTextPos;
  ValueChanged<Offset>? currentTopLeftOnChanged;
  ValueChanged<Offset>? currentTopRightOnChanged;
  ValueChanged<Offset>? currentBottomRightOnChanged;
  ValueChanged<Offset>? currentTextPosOnChanged;

  MyPainter(
      {required this.context,
      this.setState,
      this.expand,
      required this.textSize,
      required this.angle,
      this.currentTextPos,
      this.currentTextPosOnChanged,
      this.currentTopLeftOnChanged,
      this.currentTopRightOnChanged,
      this.currentBottomRightOnChanged});

  @override
  void paint(Canvas canvas, Size size) {
    var borderRectPaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    //
    var circlePaint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;
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
      maxWidth: double.infinity,
    );
    final xCenter = (size.width - textPainter.width) / 2;
    final yCenter = (size.height - textPainter.height) / 2;
    final offset = currentTextPos ?? Offset(xCenter, yCenter);

    // canvas.save();
    // canvas.scale(1.4);
    // canvas.save();

    // rotate(canvas, xCenter, yCenter, 3.14 / 2);
    // centerRotate(
    //     canvas, textPainter.size.width, textPainter.size.height, 3.14 / 2);
    final double r = sqrt(textPainter.width * textPainter.width +
            textPainter.height * textPainter.height) /
        2;
    final alpha = atan(textPainter.height / textPainter.width);
    final beta = alpha + angle * pi / 180;
    final shiftY = r * sin(beta);
    final shiftX = r * cos(beta);
    final translateX = textPainter.width / 2 - shiftX;
    final translateY = textPainter.height / 2 - shiftY;

    canvas.translate(translateX + offset.dx, translateY + offset.dy);
    canvas.rotate(angle * pi / 180);

    // canvas.rotate(30 * 3.14 / 180);

    canvas.drawRect(
        Rect.fromPoints(const Offset(-5, -5),
            Offset(textPainter.width + 5, textPainter.height + 5)),
        borderRectPaint);

    canvas.drawCircle(Offset(-5, -5), 2, circlePaint);
    canvas.drawCircle(Offset(textPainter.width + 5, -5), 10, circlePaint);

    canvas.drawCircle(
        Offset(textPainter.width + 5, textPainter.height + 5), 10, circlePaint);

    textPainter.paint(canvas, Offset.zero);

    // print(translateX + offset.dx);

    // canvas.restore();

    currentTextPosOnChanged?.call(offset);
    currentTopLeftOnChanged?.call(Offset(offset.dx - 5, offset.dy - 5));
    currentTopRightOnChanged
        ?.call(Offset(offset.dx + textPainter.width + 5, offset.dy - 5));
    currentBottomRightOnChanged?.call(Offset(
        offset.dx + textPainter.width + 5, offset.dy + textPainter.height + 5));
    // canvas.restore();
  }

  void rotate(Canvas canvas, double cx, double cy, double angleRadians) {
    canvas.translate(cx, cy);
    canvas.rotate(angleRadians);
    canvas.translate(-cx, -cy);
  }

  void centerRotate(Canvas canvas, double textSizeWidth, double textSizeHeight,
      double angle) {
    final double r =
        sqrt(textSizeWidth * textSizeWidth + textSizeHeight * textSizeHeight) /
            2;
    final alpha = atan(textSizeHeight / textSizeWidth);
    final beta = alpha + angle;
    final shiftY = r * sin(beta);
    final shiftX = r * cos(beta);
    final translateX = textSizeWidth / 2 - shiftX;
    final translateY = textSizeHeight / 2 - shiftY;
    canvas.translate(translateX, translateY);
    canvas.rotate(angle);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
