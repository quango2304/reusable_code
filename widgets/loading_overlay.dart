import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingOverLayWidget extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const LoadingOverLayWidget(
      {Key? key, required this.isLoading, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        if (isLoading)
          Container(
            color: Colors.black.withOpacity(0.3),
          ),
        if (isLoading)
          SpinKitFadingCube(
            itemBuilder: (BuildContext context, int index) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: index.isEven ? Colors.red : Colors.grey,
                ),
              );
            },
          )
      ],
    );
  }
}
