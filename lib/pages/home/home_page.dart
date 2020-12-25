import 'package:flutter/material.dart';
import 'package:virtualhole_api_client_dart/virtualhole_api_client_dart.dart';
import '../../configs/configs.dart';
import '../../ui/ui.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    VirtualHoleApiClient vHoleApi =
        VirtualHoleApiClient.managed(domain: AppConfig.virtualHoleApi);

    return ContentFeed(
      tabs: [
        ContentFeedTab(
          name: 'Discover',
          builder: vHoleApi.contents.getDiscover,
          request: ContentRequest(),
        ),
        ContentFeedTab(
          name: 'Community',
          builder: vHoleApi.contents.getCommunity,
          request: ContentRequest(),
        ),
        ContentFeedTab(
          name: 'Live',
          builder: vHoleApi.contents.getLive,
          request: ContentRequest(),
        ),
        ContentFeedTab(
          name: 'Scheduled',
          builder: vHoleApi.contents.getSchedule,
          request: ContentRequest(),
        ),
      ],
    );
  }
}
