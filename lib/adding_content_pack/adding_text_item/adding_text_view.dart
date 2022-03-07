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
    textSize += details.delta.dx / 5;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
                  )))),
        ),
      ],
    );
  }
}

enum TextEditingAction { rotate, scale, delete }

enum TextState { flip, rotate }
