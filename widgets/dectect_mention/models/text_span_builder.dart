import 'package:application/src/core/core.dart';
import 'package:flutter/material.dart';

class DetectContentTextSpanBuilder {
  final Function(ContentDetection detection)? onTapDetection;
  final TextStyle defaultTextStyle;
  final Map<DetectedType, TextStyle> detectionTextStyles;

  final Map<DetectedType, RegExp> regularExpressions;

  DetectContentTextSpanBuilder({
    required this.regularExpressions,
    required this.defaultTextStyle,
    this.detectionTextStyles = const {},
    this.onTapDetection,
  });

  TextSpan build(String text, {bool isEditing = false}) {
    final textSpanList = <TextSpan>[];
    RegExp allRegex;

    allRegex = RegExp(
      regularExpressions.reverse.values.map((e) => e.pattern).join('|'),
    );
    //build the text by each matched regex and add to textSpanList
    text.splitMapJoin(
      allRegex,
      onMatch: (Match match) {
        final tag = match[0] ?? '';
        // get the DetectionType that matched
        final matchedDetectionType =
            regularExpressions.entries.lastWhere((patternMap) {
          return patternMap.value.allMatches(tag).isNotEmpty;
        }).key;
        //add the matched text with the custom style into textSpanList
        textSpanList.add(
          buildHighLightTextSpan(tag, isEditing, matchedDetectionType),
        );
        return tag;
      },
      onNonMatch: (String text) {
        //for text that not match, just return with style as usual
        textSpanList.add(
          buildNormalTextSpan(text),
        );
        return text;
      },
    );
    return TextSpan(
      style: defaultTextStyle,
      children: textSpanList,
    );
  }

  TextSpan buildNormalTextSpan(String text) {
    return TextSpan(
      text: text,
      style: defaultTextStyle,
    );
  }

  TextSpan buildHighLightTextSpan(
    String tag,
    bool isEditing,
    DetectedType matchedDetectionType,
  ) {
    return TextSpan(
      text: tag,
      recognizer: isEditing
          ? null
          : (TapGestureRecognizer()
            ..onTap = () {
              onTapDetection?.call(
                ContentDetection(matchedDetectionType, TextRange.empty, tag),
              );
            }),
      style: detectionTextStyles[matchedDetectionType],
    );
  }
}
