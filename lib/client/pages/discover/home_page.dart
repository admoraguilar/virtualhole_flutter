import 'package:flutter/material.dart';
import 'package:virtualhole_flutter/api/api.dart';
import 'package:virtualhole_flutter/api/virtualhole_api_wrapper.dart';
import 'package:virtualhole_flutter/client/configs/configs.dart';
import 'package:virtualhole_flutter/client/ui/ui.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    VirtualHoleApiWrapperClient vHoleApi =
        VirtualHoleApiWrapperClient.managed(domain: AppConfig.virtualHoleApi);

    return ContentFeed(
      builder: vHoleApi.contents.getDiscover,
      tabs: [
        ContentFeedTab(
          name: 'Discover',
          request: ContentRequest(),
        )
      ],
    );
  }
}
