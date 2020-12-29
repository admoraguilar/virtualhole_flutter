import 'package:virtualhole_api_client_dart/virtualhole_api_client_dart.dart';
import '../../configs/configs.dart';
import '../../ui/ui.dart';

class AppContentFeedTabFactory {
  static VirtualHoleApiClient _vHoleApi =
      VirtualHoleApiClient.managed(domain: AppConfig.virtualHoleApi);

  static List<ContentFeedTab> creator(List<Creator> creators) {
    return [
      live(
        request: ContentRequest(
          isCreatorsInclude: true,
          creatorIds: creators.map((c) => c.id).toList(),
        ),
      ),
      scheduled(
        request: ContentRequest(
          isCreatorsInclude: true,
          creatorIds: creators.map((c) => c.id).toList(),
        ),
      ),
      discover(
        request: ContentRequest(
          isCreatorsInclude: true,
          creatorIds: creators.map((c) => c.id).toList(),
        ),
      ),
      community(
        request: ContentRequest(
          isCreatorRelated: true,
          creatorIds: creators.map((c) => c.id).toList(),
          creatorNames: creators.map((c) => c.name).toList(),
          creatorSocialIds:
              creators.expand((c) => c.socials.map((s) => s.id)).toList(),
        ),
      ),
    ];
  }

  static List<ContentFeedTab> main() {
    return [
      discover(),
      community(),
      live(),
      scheduled(),
    ];
  }

  static ContentFeedTab discover({ContentRequest request}) {
    request ??= ContentRequest();
    return ContentFeedTab(
      name: 'Discover',
      builder: (int page) => ApiResponseProvider(
        _vHoleApi.contents.getDiscover(request.copyWith(page: page)),
      ).getResult(),
    );
  }

  static ContentFeedTab community({ContentRequest request}) {
    request ??= ContentRequest();
    return ContentFeedTab(
      name: 'Community',
      builder: (int page) => ApiResponseProvider(
        _vHoleApi.contents.getCommunity(request.copyWith(page: page)),
      ).getResult(),
    );
  }

  static ContentFeedTab live({ContentRequest request}) {
    request ??= ContentRequest();
    return ContentFeedTab(
      name: 'Live',
      builder: (int page) => ApiResponseProvider(
        _vHoleApi.contents.getLive(request.copyWith(page: page)),
      ).getResult(),
    );
  }

  static ContentFeedTab scheduled({ContentRequest request}) {
    request ??= ContentRequest();
    return ContentFeedTab(
      name: 'Scheduled',
      builder: (int page) => ApiResponseProvider(
        _vHoleApi.contents.getSchedule(request.copyWith(page: page)),
      ).getResult(),
    );
  }
}
