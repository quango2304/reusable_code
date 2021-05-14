import 'package:flutter/material.dart';

extension MediaQueryExt on BuildContext {
  Size get mediaQuerySize => MediaQuery.of(this).size;

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  Widget removePadding({required Widget child}) => MediaQuery.removePadding(
        context: this,
        child: child,
        removeTop: true,
        removeBottom: true,
        removeLeft: true,
        removeRight: true,
      );
}
