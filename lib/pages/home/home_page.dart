import 'package:flutter/material.dart';
import 'package:virtualhole_api_client_dart/virtualhole_api_client_dart.dart';
import '../../configs/configs.dart';
import '../../ui/ui.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _onError(APIError error) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('${error.statusCode}: ${error.reasonPhrase}'),
        ),
      );
    }

    VirtualHoleApiClient vHoleApi =
        VirtualHoleApiClient.managed(domain: AppConfig.virtualHoleApi);

    return ContentFeed(
      tabs: [
        ContentFeedTab(
          name: 'Discover',
          builder: (int page) => APIResponseProvider(
            vHoleApi.contents.getDiscover(ContentRequest(page: page)),
            onError: _onError,
          ).getResult(),
        ),
        ContentFeedTab(
          name: 'Community',
          builder: (int page) => APIResponseProvider(
            vHoleApi.contents.getCommunity(ContentRequest(page: page)),
            onError: _onError,
          ).getResult(),
        ),
        ContentFeedTab(
          name: 'Live',
          builder: (int page) => APIResponseProvider(
            vHoleApi.contents.getLive(ContentRequest(page: page)),
            onError: _onError,
          ).getResult(),
        ),
        ContentFeedTab(
          name: 'Scheduled',
          builder: (int page) => APIResponseProvider(
            vHoleApi.contents.getSchedule(ContentRequest(page: page)),
            onError: _onError,
          ).getResult(),
        ),
      ],
      initialTabIndex: 0,
    );
  }
}
