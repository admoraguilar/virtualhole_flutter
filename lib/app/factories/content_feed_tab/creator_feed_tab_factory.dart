import 'package:virtualhole_api_client_dart/virtualhole_api_client_dart.dart';
import '../../../virtualhole_client.dart';

class CreatorFeedTabBuilder extends ContentFeedTabBuilder {
  CreatorFeedTabBuilder()
      : creators = [],
        _isSingle = false;

  CreatorFeedTabBuilder.single(Creator creator)
      : assert(creator != null),
        creators = [creator],
        _isSingle = true;

  final List<Creator> creators;
  final bool _isSingle;

  factory CreatorFeedTabBuilder.fromIds(List<String> creatorIds) {
    CreatorFeedTabBuilder builder = CreatorFeedTabBuilder();
    creatorIds.forEach((String id) {
      builder.creators.add(Creator(id: id));
    });
    return builder;
  }

  @override
  List<ContentFeedTab> build() {
    ContentFeedTab _live() => live(
          request: ContentRequest(
            isCreatorsInclude: true,
            creatorIds: creators.map((c) => c.id).toList(),
          ),
        );

    ContentFeedTab _scheduled() => scheduled(
          request: ContentRequest(
            isCreatorsInclude: true,
            creatorIds: creators.map((c) => c.id).toList(),
          ),
        );

    ContentFeedTab _discover() => discover(
          request: ContentRequest(
            isCreatorsInclude: true,
            creatorIds: creators.map((c) => c.id).toList(),
          ),
        );

    ContentFeedTab _community() => community(
          request: ContentRequest(
            isCreatorRelated: true,
            creatorIds: creators.map((c) => c.id).toList(),
          ),
        );

    if (_isSingle) {
      return [
        _live(),
        _scheduled(),
        _discover(),
        _community(),
      ];
    } else {
      return [
        _discover(),
        _community(),
        _live(),
        _scheduled(),
      ];
    }
  }
}
