import 'package:flutter/material.dart';

extension PaddingExtensions on Widget {
  Widget expand() {
    return Expanded(child: this);
  }

  Widget round() {
    return ClipOval(child: this);
  }

  Widget radius(double val) {
    return ClipRRect(
      child: this,
      borderRadius: BorderRadius.circular(val),
    );
  }
}