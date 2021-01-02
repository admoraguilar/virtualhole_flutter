import 'package:virtualhole_api_client_dart/virtualhole_api_client_dart.dart';
import '../../../virtualhole_client.dart';

class FollowedFeedTabBuilder extends ContentFeedTabBuilder {
  FollowedFeedTabBuilder(this.creators)
      : assert(creators != null && creators.length > 0);

  final List<Creator> creators;

  @override
  List<ContentFeedTab> build() {
    return [
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
        ),
      ),
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
    ];
  }
}
