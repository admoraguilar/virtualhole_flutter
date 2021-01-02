import '../../virtualhole_api_client_dart.dart';

class ContentRequest extends PagedRequest {
  const ContentRequest({
    String locale,
    int page,
    int pageSize,
    int maxPages,
    this.isSocialTypeInclude,
    this.socialType,
    this.isContentTypeInclude,
    this.contentType,
    this.isCreatorsInclude,
    this.isCreatorRelated,
    this.creatorIds,
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
  final bool isCreatorRelated;
  final List<String> creatorIds;
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
      'isCreatorRelated': isCreatorRelated,
      'creatorIds': creatorIds,
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
    bool isCreatorRelated,
    List<String> creatorIds,
    bool isCheckCreatorAffiliations,
    bool isAffiliationsAll,
    bool isAffiliationsInclude,
    List<String> creatorAffiliations,
    bool isSortAscending,
  }) {
    return ContentRequest(
      locale: locale ?? this.locale,
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
      maxPages: maxPages ?? this.maxPages,
      isSocialTypeInclude: isSocialTypeInclude ?? this.isSocialTypeInclude,
      socialType: socialType ?? this.socialType,
      isContentTypeInclude: isContentTypeInclude ?? this.isContentTypeInclude,
      contentType: contentType ?? this.contentType,
      isCreatorsInclude: isCreatorsInclude ?? this.isCreatorsInclude,
      isCreatorRelated: isCreatorRelated ?? this.isCreatorRelated,
      creatorIds: creatorIds ?? this.creatorIds,
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
