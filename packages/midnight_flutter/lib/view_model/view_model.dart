import 'package:flutter/material.dart';
import '../midnight_flutter.dart';

abstract class ViewModel {
  static _InstanceContainer _instanceContainer = _InstanceContainer();

  static T get<T extends ViewModel>() {
    return _instanceContainer.get<T>();
  }

  static void add(ViewModel viewModel) {
    _instanceContainer.add(viewModel);
  }

  static void remove(ViewModel viewModel) {
    _instanceContainer.remove(viewModel);
  }

  VoidCallbackListReadOnly get onSetState => _onSetState;
  VoidCallbackList _onSetState = VoidCallbackList();

  void setState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _onSetState.invoke();
    });
  }
}

abstract class ViewModelController {
  static _InstanceContainer _instanceContainer = _InstanceContainer();

  static void add(ViewModelController viewModelController) {
    _instanceContainer.add(viewModelController);
  }

  static void remove(ViewModelController viewModelController) {
    _instanceContainer.remove(viewModelController);
  }
}

class _InstanceContainer {
  Map<Type, Object> _instanceMap = Map<Type, Object>();

  T get<T>() {
    return _instanceMap[T] as T;
  }

  void add(Object object) {
    _instanceMap[object.runtimeType] = object;
  }

  void remove(Object object) {
    _instanceMap.remove(object.runtimeType);
  }
}
