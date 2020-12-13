import 'package:virtualhole_flutter/common/common.dart';

class CounterViewModel extends ViewModel {
  VoidCallbackListReadOnly get onIncrement => _onIncrement;
  VoidCallbackList _onIncrement = VoidCallbackList();

  VoidCallbackListReadOnly get onDecrement => _onDecrement;
  VoidCallbackList _onDecrement = VoidCallbackList();

  int get counter => _counter;
  set counter(int value) {
    _counter = value;
    setState();
  }

  int _counter = 0;

  void increment() {
    _onIncrement.invoke();
  }

  void decrement() {
    _onDecrement.invoke();
  }
}
