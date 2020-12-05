import 'package:virtualhole_flutter/common/common.dart';

class CounterViewModel {
  VoidCallbackListReadOnly get onIncrement => _onIncrement;
  VoidCallbackList _onIncrement = VoidCallbackList();

  VoidCallbackListReadOnly get onDecrement => _onDecrement;
  VoidCallbackList _onDecrement = VoidCallbackList();

  Observable<int> get counter => _counter;
  Observable<int> _counter = Observable(0);

  void increment() {
    _onIncrement.invoke();
  }

  void decrement() {
    _onDecrement.invoke();
  }
}
