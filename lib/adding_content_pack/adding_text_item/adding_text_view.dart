import 'dart:ui';

import 'package:flutter/material.dart';

import 'adding_text_item_painter.dart';

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

    return Column(
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
                    startOffset: Offset(offsetX, offsetY),
                    translate: Offset(30, 0),
                    rotateAngle: 0,
                    scaleFactor: 2,
                  )))),
        ),
      ],
    );
  }
}

enum TextEditingAction { rotate, scale, delete }

enum TextState { flip, rotate }
