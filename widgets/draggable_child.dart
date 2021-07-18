import 'package:flutter/material.dart';

abstract class DraggableMixin<T extends StatefulWidget> extends State<T> {
  Offset position;
  Widget buildDraggableChild();

  double get childWidth;
  double get childHeight;

  Offset get initialOffset;

  @override
  Widget build(BuildContext context) {
    position ??= initialOffset;
    return SizedBox(
      width: screenWidth,
      height: screenHeight,
      child: Stack(
        children: [
          Positioned(
            left: position.dx,
            top: position.dy,
            child: Draggable(
              feedback: SizedBox(
                child: buildDraggableChild(),
                width: 150,
              ),
              childWhenDragging: SizedBox(),
              onDraggableCanceled: (_, offset) {
                var dx = offset.dx;
                var dy = offset.dy;
                if (dy > screenHeight - childHeight) {
                  dy = screenHeight - childHeight;
                }
                if( dx > screenWidth - childWidth) {
                  dx = screenWidth - childWidth;
                }
                if (dy < 0) {
                  dy = 0;
                }
                if (dx < 0) {
                  dx = 0;
                }
                setState(() => position = Offset(dx, dy));
              },
              child: SizedBox(
                child: buildDraggableChild(),
                width: 150,
              ),
            ),
          )
        ],
      ),
    );
  }

  double get screenWidth => MediaQuery.of(context).size.width;
  double get screenHeight => MediaQuery.of(context).size.height;
}
