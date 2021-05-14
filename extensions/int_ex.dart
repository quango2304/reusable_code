extension IntExtensions on int {
    Duration get seconds => Duration(seconds: this);
    Duration get milliseconds => Duration(milliseconds: this);
    Duration get hours => Duration(hours: this);
    Duration get minutes => Duration(minutes: this);

    // 5.toSecondsDelay(() {
    //    print("after 5 minutes");
    // });
    void toMinutesDelay(Function computation) {
      Future.delayed(this.minutes, () {
        computation();
      });
    }

    // 5.toSecondsDelay(() {
    //    print("after 5 sec");
    // });
    void toSecondsDelay(Function computation) {
      Future.delayed(this.seconds, () {
        computation();
      });
    }

    // 500.toMillisecondsDelay(() {
    //    print("after 500 mil");
    // });
    void toMillisecondsDelay(Function computation) {
      Future.delayed(this.milliseconds, () {
        computation();
      });
    }
}