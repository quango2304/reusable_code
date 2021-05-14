import 'package:coffee_shop/constants/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppNetworkImage extends StatelessWidget {
  final String? url;
  final Widget? placeholder;
  double? width;
  double? height;
  final BoxFit? fit;
  final Color? backgroundColor;
  final double radius;

  AppNetworkImage(this.url,
      {Key? key,
      this.placeholder,
      this.width,
      this.height,
      this.fit,
      this.backgroundColor,
      double? size,
      this.radius = 0.0})
      : super(key: key) {
    if (size != null) {
      this.width = size;
      this.height = size;
    }
  }

  int? get getCacheHeight {
    if (height != null) {
      return (height! * 2).toInt();
    }
  }

  int? get getCacheWidth {
    if (width != null) {
      return (width! * 2).toInt();
    }
  }

  Widget getPlaceHolder() {
    return placeholder ??
        Container(
          color: AppColors.cCACACA,
          width: width ?? double.maxFinite,
          height: height ?? double.maxFinite,
        );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Container(
        color: backgroundColor ?? Colors.transparent,
        child: Image.network(
          url ?? '',
          width: width,
          height: height,
          // cacheWidth: getCacheHeight != null ? null : getCacheWidth,
          // cacheHeight: getCacheHeight,
          errorBuilder: (context, error, stackTrace) {
            return getPlaceHolder();
          },
          loadingBuilder: (context, child, loadingProgress) {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: loadingProgress == null ? child : getPlaceHolder(),
            );
          },
          frameBuilder: (BuildContext context, Widget child, int? frame,
              bool wasSynchronouslyLoaded) {
            if (wasSynchronouslyLoaded) {
              return child;
            }
            return frame != null ? child : getPlaceHolder();
          },
          fit: fit ?? BoxFit.cover,
        ),
      ),
    );
  }
}
