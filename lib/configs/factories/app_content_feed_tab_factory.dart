import 'package:virtualhole_api_client_dart/virtualhole_api_client_dart.dart';
import '../../configs/configs.dart';
import '../../ui/ui.dart';

class AppContentFeedTabFactory {
  static VirtualHoleApiClient _vHoleApi =
      VirtualHoleApiClient.managed(domain: AppConfig.virtualHoleApi);

  static List<ContentFeedTab> main() {
    return [
      discover(),
      community(),
      live(),
      scheduled(),
    ];
  }

  static ContentFeedTab discover() {
    return ContentFeedTab(
      name: 'Discover',
      builder: (int page) => APIResponseProvider(
        _vHoleApi.contents.getDiscover(ContentRequest(page: page)),
      ).getResult(),
    );
  }

  static ContentFeedTab community() {
    return ContentFeedTab(
      name: 'Community',
      builder: (int page) => APIResponseProvider(
        _vHoleApi.contents.getCommunity(ContentRequest(page: page)),
      ).getResult(),
    );
  }

  static ContentFeedTab live() {
    return ContentFeedTab(
      name: 'Live',
      builder: (int page) => APIResponseProvider(
        _vHoleApi.contents.getLive(ContentRequest(page: page)),
      ).getResult(),
    );
  }

  static ContentFeedTab scheduled() {
    return ContentFeedTab(
      name: 'Scheduled',
      builder: (int page) => APIResponseProvider(
        _vHoleApi.contents.getSchedule(ContentRequest(page: page)),
      ).getResult(),
    );
  }
}
