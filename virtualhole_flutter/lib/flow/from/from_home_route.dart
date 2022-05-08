import 'package:virtual_hole/flow/to/to_followed_page.dart';
import 'package:midnight_flutter/midnight_flutter.dart';
import '../../virtualhole_client.dart';

class FromHomeRoute extends FlowContext {
  FromHomeRoute(this.index) : assert(index != null && index > -1);

  final int index;
}

class FromHomeRouteResponse extends FlowResponse<FromHomeRoute> {
  @override
  void respond() {
    if (context.index == 0) {
      navigate(ToExplorePage());
    } else if (context.index == 1) {
      navigate(ToFollowedPage());
    } else if (context.index == 2) {
      navigate(ToSearchPage());
    } else if (context.index == 3) {
      navigate(ToAboutPage());
    } else {
      navigate(ToErrorPage());
    }
  }
}
