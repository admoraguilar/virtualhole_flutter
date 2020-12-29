import 'package:midnight_flutter/midnight_flutter.dart';
import '../../virtualhole_client.dart';

class ToHomeRoute extends FlowContext {
  ToHomeRoute(this.index) : assert(index != null && index > -1);

  final int index;
}

class ToHomeRouteResponse extends FlowResponse<ToHomeRoute> {
  @override
  bool get canRespond => true;

  @override
  void respond() {
    MLog.log('home route respond');
    if (context.index == 0) {
      navigate(ToExplorePage());
    } else if (context.index == 1) {
      navigate(ToCounterPage());
    } else if (context.index == 2) {
      navigate(ToErrorPage());
    } else if (context.index == 3) {
      navigate(ToSupportPage());
    } else {
      navigate(ToErrorPage());
    }
  }
}
