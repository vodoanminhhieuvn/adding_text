import 'dart:ui';
import 'package:flutter/material.dart';
import 'adding_text_item_painter.dart';
import 'dart:math' as math;

class Screen1 extends StatefulWidget {
  @override
  _Screen1State createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> with SingleTickerProviderStateMixin {
  Color color = Colors.green;

  double textSize = 16;
  Offset offset = const Offset(0, 0);
  double scale = 1;

  late Offset leftTopOffset;
  late Offset leftBottomOffset;
  late Offset rightTopOffset;
  late Offset rightBottomOffset;

  void _onDragDown(DragDownDetails details) {
    // var touchX = details.localPosition.dx;
    // var touchY = details.localPosition.dy;
    //
    // // print(leftTopOffset.dx - 10);
    // // print(touchX);
    // // print(leftTopOffset.dx + 10);
    //
    // if (leftTopOffset.dx - 10 < touchX &&
    //     touchX < leftTopOffset.dx + 10 &&
    //     leftTopOffset.dy - 10 < touchY &&
    //     touchY < leftTopOffset.dy + 10) {
    //
    // }
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {});
  }

  Size sizeOfText(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: style),
        maxLines: 1,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    Size sizeText = sizeOfText(
        'Hello, world',
        TextStyle(
          color: Colors.black,
          fontSize: textSize,
        ));
    double offsetX = screenSize.width / 2 - sizeText.width / 2;
    double offsetY = screenSize.height / 2 - sizeText.height / 2;

    Offset startOffset = Offset(offsetX, offsetY);
    Offset center = Offset(screenSize.width / 2, screenSize.height / 2);
    Offset translate = const Offset(0, 0);
    double scaleFactor = 1;
    double rotateAngle = 0 * math.pi / 180;

    Offset newStartOffset = offsetAfterTransform(
        startOffset: startOffset,
        center: center,
        translate: translate,
        scaleFactor: scaleFactor,
        rotateAngle: rotateAngle);

    return Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: GestureDetector(
                  onPanDown: _onDragDown,
                  onPanUpdate: _onPanUpdate,
                  child: AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      color: color,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: CustomPaint(
                          painter: MyPainter(
                        context: context,
                        textSize: textSize,
                        startOffset: startOffset,
                        translate: translate,
                        rotateAngle: rotateAngle,
                        scaleFactor: scaleFactor,
                      )))),
            ),
          ],
        ),
        Positioned(
          child: Container(
            height: 4,
            width: 4,
            color: Colors.red,
          ),
          top: newStartOffset.dy - 2,
          left: newStartOffset.dx - 2,
        ),
      ],
    );
  }
}

Offset offsetAfterTransform({
  required Offset startOffset,
  required Offset center,
  required Offset translate,
  required double scaleFactor,
  required double rotateAngle,
}) {
  // translate to origin
  double dx = startOffset.dx - center.dx;
  double dy = startOffset.dy - center.dy;

  // scale
  dx = dx * scaleFactor;
  dy = dy * scaleFactor;

  // rotate
  double s = math.sin(rotateAngle);
  double c = math.cos(rotateAngle);

  // rotate point
  double dxTerm = dx;
  double dyTerm = dy;
  dx = dxTerm * c - dyTerm * s;
  dy = dxTerm * s + dyTerm * c;

  // translate back to the center point
  dx = dx + center.dx;
  dy = dy + center.dy;

  // translate
  dx = dx + translate.dx;
  dy = dy + translate.dy;

  return Offset(dx, dy);
}

enum TextEditingAction { rotate, scale, delete }

enum TextState { flip, rotate }
