import 'package:flutter/material.dart';

abstract class ViewState {}

class Loading extends ViewState {}

class Idle extends ViewState {}

class Error extends ViewState {
  final String error;

  Error(this.error);
}

class Success extends ViewState {}

abstract class BaseProvider extends ChangeNotifier {
  ViewState _state = Idle();
  ViewState get state => _state;
  set state(ViewState state) {
    if (_state == state) return;

    _state = state;
    notifyListeners();
  }

  void backToIdle() {
    Future.delayed(Duration(seconds: 1), () => state = Idle());
  }
}
