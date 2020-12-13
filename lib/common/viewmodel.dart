import 'package:flutter/material.dart';
import 'package:virtualhole_flutter/common/common.dart';

class ViewModelAdapter extends StatefulWidget {
  ViewModelAdapter({Key key, this.observables, @required this.builder})
      : super(key: key);

  final List<ViewModel> Function(BuildContext, ViewModelContainer) observables;
  final Widget Function(BuildContext, ViewModelContainer) builder;

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
    return widget.builder.call(context, ViewModelContainer.instance);
  }

  void _rebuild() {
    setState(() {});
  }

  void _initObservables() {
    if (widget.observables == null) return;
    widget.observables(context, ViewModelContainer.instance).forEach((element) {
      element.onSetState.remove(_rebuild);
      element.onSetState.add(_rebuild);
    });
  }

  void _deInitObservables() {
    if (widget.observables == null) return;
    widget.observables(context, ViewModelContainer.instance).forEach((element) {
      element.onSetState.remove(_rebuild);
    });
  }
}

class ViewModelContainer {
  static ViewModelContainer get instance => _instance ??= ViewModelContainer();
  static ViewModelContainer _instance;

  Map<Type, ViewModel> _instanceMap = Map<Type, ViewModel>();

  T get<T>() {
    return _instanceMap[T] as T;
  }

  void add(ViewModel viewModel) {
    _instanceMap[viewModel.runtimeType] = viewModel;
  }

  void remove(ViewModel viewModel) {
    _instanceMap.remove(viewModel.runtimeType);
  }
}

abstract class ViewModel {
  VoidCallbackListReadOnly get onSetState => _onSetState;
  VoidCallbackList _onSetState = VoidCallbackList();

  void setState() {
    _onSetState.invoke();
  }
}
