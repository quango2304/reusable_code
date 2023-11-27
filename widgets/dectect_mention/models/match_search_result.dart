import 'package:application/src/core/core.dart';
import 'package:flutter/material.dart';

class MatchSearchResult {
  final TextStyle textStyle;
  final DetectedType type;
  final String text;

  MatchSearchResult(this.textStyle, this.type, this.text);
}
