import 'dart:ui';

import 'package:flutter/material.dart';

import 'adding_text_item_painter.dart';

class Screen1 extends StatefulWidget {
  @override
  _Screen1State createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> with SingleTickerProviderStateMixin {
  Color color = Colors.green;
  String textString = 'Hello, world.';
  double textSize = 16;
  double angle = 90;

  TextEditingAction _currentTextEditingAction = TextEditingAction.none;

  Offset? _currenTextPos;
  Offset? _currentTopLeftPos;
  Offset? _currentTopRightPos;
  Offset? _currentBottomRightPos;

  void _onDragDown(DragDownDetails details) {
    var touchX = details.localPosition.dx;
    var touchY = details.localPosition.dy;

    print("Positioned touch: $touchX : $touchY");

    if (touchX > _currentTopLeftPos!.dx &&
        touchX < _currentTopRightPos!.dx &&
        touchY > _currentTopRightPos!.dy &&
        touchY < _currentBottomRightPos!.dy) {
      _currentTextEditingAction = TextEditingAction.move;
    }

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
    if (_currentTextEditingAction == TextEditingAction.move) {
      _currenTextPos = _currenTextPos! + details.delta;
    } else {
      var newTextFontSize = textSize + details.delta.dx / 5;

      var newTextSize =
          _textSize(textString, TextStyle(fontSize: newTextFontSize));
      var currentTextSize =
          _textSize(textString, TextStyle(fontSize: textSize));

      var xRemainder = (newTextSize.width - currentTextSize.width) / 2;
      var yRemainder = (newTextSize.height - currentTextSize.height) / 2;

      _currenTextPos = Offset(
          _currenTextPos!.dx - xRemainder, _currenTextPos!.dy - yRemainder);

      textSize = newTextFontSize;
    }

    setState(() {});
  }

  Size _textSize(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: style),
        maxLines: 1,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
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
              onPanEnd: (DragEndDetails details) {
                _currentTextEditingAction = TextEditingAction.none;
                setState(() {});
              },
              child: AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  color: color,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: CustomPaint(
                      painter: MyPainter(
                          context: context,
                          textSize: textSize,
                          angle: angle,
                          currentTextPos: _currenTextPos,
                          currentTopLeftOnChanged: (Offset currentTopLeftPos) {
                            _currentTopLeftPos = currentTopLeftPos;

                            if (!mounted) {
                              setState(() {});
                            }
                          },
                          currentTopRightOnChanged:
                              (Offset currentTopRightPos) {
                            _currentTopRightPos = currentTopRightPos;
                            if (!mounted) {
                              setState(() {});
                            }
                          },
                          currentBottomRightOnChanged:
                              (Offset currentBottomRightPos) {
                            _currentBottomRightPos = currentBottomRightPos;
                            if (!mounted) {
                              setState(() {});
                            }
                          },
                          currentTextPosOnChanged: (Offset currentTextPos) {
                            _currenTextPos = currentTextPos;

                            if (!mounted) {
                              setState(() {});
                            }
                          })))),
        ),
      ],
    );
  }
}

enum TextEditingAction { rotate, scale, delete, move, none }

enum TextState { flip, rotate }
