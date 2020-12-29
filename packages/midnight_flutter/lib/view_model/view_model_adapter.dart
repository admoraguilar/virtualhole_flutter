import 'package:flutter/material.dart';
import '../midnight_flutter.dart';

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
