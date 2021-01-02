import 'package:virtualhole_api_client_dart/virtualhole_api_client_dart.dart';
import '../../../virtualhole_client.dart';

abstract class ContentFeedTabBuilder {
  List<ContentFeedTab> build();

  ContentFeedTab discover({ContentRequest request}) {
    request ??= ContentRequest();
    return ContentFeedTab(
      name: 'Discover',
      builder: (int page) => ApiResponseProvider(
        ClientFactory.managed()
            .vHoleApi
            .contents
            .getDiscover(request.copyWith(page: page)),
      ).getResult(),
    );
  }

  ContentFeedTab community({ContentRequest request}) {
    request ??= ContentRequest();
    return ContentFeedTab(
      name: 'Community',
      builder: (int page) => ApiResponseProvider(
        ClientFactory.managed()
            .vHoleApi
            .contents
            .getCommunity(request.copyWith(page: page)),
      ).getResult(),
    );
  }

  ContentFeedTab live({ContentRequest request}) {
    request ??= ContentRequest();
    return ContentFeedTab(
      name: 'Live',
      builder: (int page) => ApiResponseProvider(
        ClientFactory.managed()
            .vHoleApi
            .contents
            .getLive(request.copyWith(page: page)),
      ).getResult(),
    );
  }

  ContentFeedTab scheduled({ContentRequest request}) {
    request ??= ContentRequest();
    return ContentFeedTab(
      name: 'Scheduled',
      builder: (int page) => ApiResponseProvider(
        ClientFactory.managed()
            .vHoleApi
            .contents
            .getSchedule(request.copyWith(page: page)),
      ).getResult(),
    );
  }
}
