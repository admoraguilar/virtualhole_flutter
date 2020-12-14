import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:virtualhole_flutter/common/common.dart';

class ViewModelAdapter extends StatefulWidget {
  ViewModelAdapter({Key key, this.observables, @required this.builder})
      : super(key: key);

  final List<ViewModel> Function(BuildContext) observables;
  final Widget Function(BuildContext) builder;

  @override
  _ViewModelAdapterState createState() => _ViewModelAdapterState();
}

class _ViewModelAdapterState extends State<ViewModelAdapter> {
  @override
  void initState() {
    super.initState();
    _initObservables();
  }

  @override
  void deactivate() {
    super.deactivate();
    _deInitObservables();
  }

  @override
  Widget build(BuildContext context) {
    _initObservables();
    return widget.builder.call(context);
  }

  void _rebuild() {
    setState(() {});
  }

  void _initObservables() {
    if (widget.observables == null) return;
    widget.observables(context).forEach((element) {
      element.onSetState.remove(_rebuild);
      element.onSetState.add(_rebuild);
    });
  }

  void _deInitObservables() {
    if (widget.observables == null) return;
    widget.observables(context).forEach((element) {
      element.onSetState.remove(_rebuild);
    });
  }
}

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
