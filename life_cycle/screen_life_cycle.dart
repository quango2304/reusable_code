import 'package:flutter/material.dart';

abstract class ScreenLifeCycle<T extends StatefulWidget>  extends State<T>  with WidgetsBindingObserver{
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @mustCallSuper
  void onResumed() {
    print("ScreenLifeCycle onResumed $T");
  }

  @mustCallSuper
  void onPaused() {
    print("ScreenLifeCycle onPaused $T");
  }

  @mustCallSuper
  void onInactive() {
    print("ScreenLifeCycle onInactive $T");
  }

  @mustCallSuper
  void onDetached() {
    print("ScreenLifeCycle onDetached $T");
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        onResumed();
        break;
      case AppLifecycleState.paused:
        onPaused();
        break;
      case AppLifecycleState.inactive:
        onInactive();
        break;
      case AppLifecycleState.detached:
        onDetached();
        break;
      default:
        break;
    }
    return super.didChangeAppLifecycleState(state);
  }
}
