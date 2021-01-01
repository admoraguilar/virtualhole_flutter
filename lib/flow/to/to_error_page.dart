import 'package:flutter/material.dart';
import 'package:midnight_flutter/midnight_flutter.dart';
import '../../virtualhole_client.dart';

class ToErrorPage extends FlowContext {}

class ToErrorPageResponse extends FlowResponse<ToErrorPage> {
  @override
  void respond() {
    pages.add(FlowPage(
      key: UniqueKey(),
      name: '/error',
      child: ErrorPage(),
    ));
  }
}
