import 'package:flutter/material.dart';

class InkWellWrapper extends StatelessWidget {
  final Color color;
  final VoidCallback onTap;
  final Widget child;
  final bool radius;

  const InkWellWrapper(
      {Key key, this.color, @required this.onTap, @required this.child, this.radius = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: child,
        ),
      ),
    );
  }
}
