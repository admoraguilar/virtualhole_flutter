import 'package:virtualhole_flutter/api/api.dart';

class ContentRequest extends PagedRequest {
  const ContentRequest({
    DateTime timestamp,
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
    this.creatorSocialUrls,
    this.isCheckCreatorAffiliations,
    this.isAffiliationsAll,
    this.isAffiliationsInclude,
    this.creatorAffiliations,
    this.isSortAscending,
  }) : super(
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
  final bool isCheckCreatorAffiliations;
  final bool isAffiliationsAll;
  final bool isAffiliationsInclude;
  final List<String> creatorAffiliations;
  final bool isSortAscending;

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
      'creatorSocialUrls': creatorSocialUrls,
      'isCheckCreatorAffiliations': isCheckCreatorAffiliations,
      'isAffiliationsAll': isAffiliationsAll,
      'isAffiliationsInclude': isAffiliationsInclude,
      'creatorAffiliations': creatorAffiliations,
      'isSortAscending': isSortAscending,
    });
    return superMap;
  }

  ContentRequest copyWith({
    DateTime timestamp,
    String locale,
    int page,
    int pageSize,
    int maxPages,
    bool isSocialTypeInclude,
    List<String> socialType,
    bool isContentTypeInclude,
    List<String> contentType,
    bool isCreatorsInclude,
    List<String> creatorIds,
    bool isCreatorRelated,
    List<String> creatorNames,
    List<String> creatorSocialIds,
    List<String> creatorSocialUrls,
    bool isCheckCreatorAffiliations,
    bool isAffiliationsAll,
    bool isAffiliationsInclude,
    List<String> creatorAffiliations,
    bool isSortAscending,
  }) {
    return ContentRequest(
      timestamp: timestamp ?? this.timestamp,
      locale: locale ?? this.locale,
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
      maxPages: maxPages ?? this.maxPages,
      isSocialTypeInclude: isSocialTypeInclude ?? this.isSocialTypeInclude,
      socialType: socialType ?? this.socialType,
      isContentTypeInclude: isContentTypeInclude ?? this.isContentTypeInclude,
      contentType: contentType ?? this.contentType,
      isCreatorsInclude: isCreatorsInclude ?? this.isCreatorsInclude,
      creatorIds: creatorIds ?? this.creatorIds,
      isCreatorRelated: isCreatorRelated ?? this.isCreatorRelated,
      creatorNames: creatorNames ?? this.creatorNames,
      creatorSocialIds: creatorSocialIds ?? this.creatorSocialIds,
      creatorSocialUrls: creatorSocialUrls ?? this.creatorSocialUrls,
      isCheckCreatorAffiliations:
          isCheckCreatorAffiliations ?? this.isCheckCreatorAffiliations,
      isAffiliationsAll: isAffiliationsAll ?? this.isAffiliationsAll,
      isAffiliationsInclude:
          isAffiliationsInclude ?? this.isAffiliationsInclude,
      creatorAffiliations: creatorAffiliations ?? this.creatorAffiliations,
      isSortAscending: isSortAscending ?? this.isSortAscending,
    );
  }
}
