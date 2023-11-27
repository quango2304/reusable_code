import 'dart:ui';

import 'package:application/src/core/core.dart';


class ContentDetection extends Equatable {
  final DetectedType type;
  final TextRange range;
  final String text;

  const ContentDetection(this.type, this.range, this.text);

  @override
  String toString() {
    return 'ContentDetection{type: $type, range: $range, text: $text}';
  }

  @override
  List<Object?> get props => [type, range, text];
}
