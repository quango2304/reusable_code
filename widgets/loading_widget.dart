import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingEffectWidget extends StatelessWidget {
  final Widget child;
  final double borderRadius;

  const LoadingEffectWidget(
      {Key? key, required this.child, this.borderRadius = 0.0})
      : super(key: key);

  factory LoadingEffectWidget.text({required double width}) {
    return LoadingEffectWidget(
      child: Container(
        width: width,
        height: 14,
        color: Colors.grey,
      ),
      borderRadius: 4,
    );
  }

  factory LoadingEffectWidget.container(
      {required double width, double? height}) {
    return LoadingEffectWidget(
      child: Container(
        width: width,
        height: height ?? width,
        color: Colors.grey,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: child,
      ),
    );
  }
}
