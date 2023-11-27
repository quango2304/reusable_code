import 'package:application/src/core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
export 'models/content_detection.dart';
export 'models/detect_type.dart';
export 'models/match_search_result.dart';
export 'models/text_span_builder.dart';
export 'nickname_detection_regex.dart';

class DetectMentionTextController extends TextEditingController {
  final StreamController<ContentDetection> _detectionStream =
      StreamController<ContentDetection>.broadcast();

  @override
  void dispose() {
    _detectionStream.close();
    super.dispose();
  }

  final Map<DetectedType, TextStyle> detectionTextStyles = {};

  final Map<DetectedType, RegExp> _regularExpressions = {
    DetectedType.mention: atSignRegExp,
    DetectedType.hashtag: hashTagRegExp,
    DetectedType.url: urlRegex,
  };

  StreamSubscription<ContentDetection> subscribeToDetection(
    Function(ContentDetection detected) listener,
  ) {
    return _detectionStream.stream.listen(listener);
  }

  void setTextStyle(DetectedType type, TextStyle style) {
    detectionTextStyles[type] = style;
  }

  void setRegexp(DetectedType type, RegExp regExp) {
    _regularExpressions[type] = regExp;
  }

  void replaceRange(String newValue, TextRange range) {
    final newValueWithSpace = '$newValue ';
    final newText =
        text.replaceRange(range.start, range.end, newValueWithSpace);
    final newRange = TextRange(
      start: range.start,
      end: range.start + newValueWithSpace.length,
    );
    final newTextSelection = TextSelection.collapsed(offset: newRange.end);
    value = value.copyWith(text: newText, selection: newTextSelection);
  }

  void _processNewValue(TextEditingValue newValue) {
    var currentPosition = newValue.selection.baseOffset;
    if (currentPosition == -1) {
      currentPosition = 0;
    }
    if (currentPosition > newValue.text.length) {
      currentPosition = newValue.text.length - 1;
    }
    final subString = newValue.text.substring(0, currentPosition);

    final lastPart = subString.split(' ').last.split('\n').last;
    final startIndex = currentPosition - lastPart.length;
    final detectionContent =
        newValue.text.substring(startIndex).split(' ').first.split('\n').first;
    _detectionStream.add(
      ContentDetection(
        getType(detectionContent),
        TextRange(start: startIndex, end: startIndex + detectionContent.length),
        detectionContent,
      ),
    );
  }

  DetectedType getType(String word) {
    return _regularExpressions.keys.firstWhere(
      (type) => _regularExpressions[type]!.hasMatch(word),
      orElse: () => DetectedType.plainText,
    );
  }

  @override
  set value(TextEditingValue newValue) {
    _processNewValue(newValue);
    super.value = newValue;
  }

  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    required bool withComposing,
  }) {
    return DetectContentTextSpanBuilder(
      regularExpressions: _regularExpressions,
      defaultTextStyle: style ?? const TextStyle(),
      detectionTextStyles: detectionTextStyles,
    ).build(text, isEditing: true);
  }
}
