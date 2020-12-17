import 'callback.dart';

class Observable<T> with GenericObservableReadOnly<T>, ObservableReadOnly {
  Observable(T value) {
    this.value = value;
  }

  T get value => _value;
  set value(T value) {
    _value = value;
    _onChange.invoke(_value);
    _onChangeVoid.invoke();
  }

  T _value;
}

abstract class GenericObservableReadOnly<T> {
  FunctionListReadOnly get onChange => _onChange;
  FunctionList _onChange = FunctionList();
}

abstract class ObservableReadOnly {
  VoidCallbackListReadOnly get onChangeVoid => _onChangeVoid;
  VoidCallbackList _onChangeVoid = VoidCallbackList();
}
