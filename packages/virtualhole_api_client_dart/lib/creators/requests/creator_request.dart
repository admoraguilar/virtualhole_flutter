import '../../virtualhole_api_client_dart.dart';

class CreatorRequest extends PagedRequest {
  const CreatorRequest({
    DateTime timestamp,
    String locale,
    int page,
    int pageSize,
    int maxPages,
    this.search,
    this.isHidden,
    this.isCheckForIsGroup,
    this.isGroup,
    this.isCheckForDepth,
    this.depth,
    this.isCheckForAffiliations,
    this.isAffiliationsAll,
    this.isAffiliationsInclude,
    this.affiliations,
  }) : super(
          locale: locale,
          page: page,
          pageSize: pageSize,
          maxPages: maxPages,
        );

  final String search;
  final bool isHidden;
  final bool isCheckForIsGroup;
  final bool isGroup;
  final bool isCheckForDepth;
  final int depth;
  final bool isCheckForAffiliations;
  final bool isAffiliationsAll;
  final bool isAffiliationsInclude;
  final List<String> affiliations;

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> superMap = super.toJson();
    superMap.addAll({
      'search': search,
      'isHidden': isHidden,
      'isCheckForIsGroup': isCheckForIsGroup,
      'isGroup': isGroup,
      'isCheckForDepth': isCheckForDepth,
      'depth': depth,
      'isCheckForAffiliations': isCheckForAffiliations,
      'isAffiliationsAll': isAffiliationsAll,
      'isAffiliationsInclude': isAffiliationsInclude,
      'affiliations': affiliations,
    });
    return superMap;
  }

  CreatorRequest copyWith({
    DateTime timestamp,
    String locale,
    int page,
    int pageSize,
    int maxPages,
    String search,
    bool isHidden,
    bool isCheckForIsGroup,
    bool isGroup,
    bool isCheckForDepth,
    int depth,
    bool isCheckForAffiliations,
    bool isAffiliationsAll,
    bool isAffiliationsInclude,
    List<String> affiliations,
  }) {
    return CreatorRequest(
      timestamp: timestamp ?? this.timestamp,
      locale: locale ?? this.locale,
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
      maxPages: maxPages ?? this.maxPages,
      search: search ?? this.search,
      isHidden: isHidden ?? this.isHidden,
      isCheckForIsGroup: isCheckForIsGroup ?? this.isCheckForIsGroup,
      isGroup: isGroup ?? this.isGroup,
      isCheckForDepth: isCheckForDepth ?? this.isCheckForDepth,
      depth: depth ?? this.depth,
      isCheckForAffiliations:
          isCheckForAffiliations ?? this.isCheckForAffiliations,
      isAffiliationsAll: isAffiliationsAll ?? this.isAffiliationsAll,
      isAffiliationsInclude:
          isAffiliationsInclude ?? this.isAffiliationsInclude,
      affiliations: affiliations ?? this.affiliations,
    );
  }
}
