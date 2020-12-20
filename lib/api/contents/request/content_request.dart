import 'package:virtualhole_flutter/api/api.dart';

class ContentRequest extends PagedRequest {
  const ContentRequest(
      {DateTime timestamp,
      String locale,
      int page,
      int pageSize,
      int maxPages,
      this.isSocialTypeInclude,
      this.socialType,
      this.isContentTypeInclude,
      this.contentType,
      this.isCreatorsInclude,
      this.creatorIds,
      this.isCreatorRelated,
      this.creatorNames,
      this.creatorSocialIds,
      this.creatorSocialUrls})
      : super(
          timestamp: timestamp,
          locale: locale,
          page: page,
          pageSize: pageSize,
          maxPages: maxPages,
        );

  final bool isSocialTypeInclude;
  final List<String> socialType;
  final bool isContentTypeInclude;
  final List<String> contentType;
  final bool isCreatorsInclude;
  final List<String> creatorIds;
  final bool isCreatorRelated;
  final List<String> creatorNames;
  final List<String> creatorSocialIds;
  final List<String> creatorSocialUrls;

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> superMap = super.toJson();
    superMap.addAll({
      'isSocialTypeInclude': isSocialTypeInclude,
      'socialType': socialType,
      'isContentTypeInclude': isContentTypeInclude,
      'contentType': contentType,
      'isCreatorsInclude': isCreatorsInclude,
      'creatorIds': creatorIds,
      'isCreatorRelated': isCreatorRelated,
      'creatorNames': creatorNames,
      'creatorSocialIds': creatorSocialIds,
      'creatorSocialUrls': creatorSocialUrls
    });
    return superMap;
  }
}
