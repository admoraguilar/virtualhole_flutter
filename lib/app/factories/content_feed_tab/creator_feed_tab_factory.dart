import 'package:virtualhole_api_client_dart/virtualhole_api_client_dart.dart';
import '../../../virtualhole_client.dart';

class CreatorFeedTabBuilder extends ContentFeedTabBuilder {
  CreatorFeedTabBuilder(this.creator) : assert(creator != null);

  final Creator creator;

  @override
  List<ContentFeedTab> build() {
    return [
      live(
        request: ContentRequest(
          isCreatorsInclude: true,
          creatorIds: [creator.id],
        ),
      ),
      scheduled(
        request: ContentRequest(
          isCreatorsInclude: true,
          creatorIds: [creator.id],
        ),
      ),
      discover(
        request: ContentRequest(
          isCreatorsInclude: true,
          creatorIds: [creator.id],
        ),
      ),
      community(
        request: ContentRequest(
          isCreatorRelated: true,
          creatorIds: [creator.id],
        ),
      ),
    ];
  }
}
