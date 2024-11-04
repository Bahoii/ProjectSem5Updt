import 'dart:async';
import 'package:flutter/material.dart';

class TimerModel extends ChangeNotifier {
  int _timerCount = 30;
  bool _isResendEnabled = false;
  Timer? _timer;

  int get timerCount => _timerCount;
  bool get isResendEnabled => _isResendEnabled;

  void startTimer() {
    _isResendEnabled = false;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timerCount == 0) {
        _timer!.cancel();
        _isResendEnabled = true;
        notifyListeners();
      } else {
        _timerCount--;
        notifyListeners();
      }
    });
  }

  void resendCode() {
    _timerCount = 30;
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
