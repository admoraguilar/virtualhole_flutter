import 'package:flutter/material.dart';

class FunctionList<T> implements FunctionListReadOnly {
  List<Function(T)> _callback = [];

  void add(Function(T) callback) {
    _callback.add(callback);
  }

  void remove(Function(T) callback) {
    _callback.remove(callback);
  }

  void invoke(T value) {
    _callback.forEach((element) {
      element.call(value);
    });
  }
}

abstract class FunctionListReadOnly<T> {
  void add(Function(T) callback);
  void remove(Function(T) callback);
}

class VoidCallbackList implements VoidCallbackListReadOnly {
  List<VoidCallback> _callback = [];

  void add(VoidCallback callback) {
    _callback.add(callback);
  }

  void remove(VoidCallback callback) {
    _callback.remove(callback);
  }

  void invoke() {
    _callback.forEach((element) {
      element.call();
    });
  }
}

abstract class VoidCallbackListReadOnly {
  void add(VoidCallback callback);
  void remove(VoidCallback callback);
}
