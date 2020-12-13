import 'package:virtualhole_flutter/api/contents/creators/requests/list_creators_request.dart';

class ListCreatorsRegexRequest extends ListCreatorsRequest {
  const ListCreatorsRegexRequest({
    int page,
    int pageSize,
    int maxPages,
    bool isHidden,
    bool isCheckForAffiliations,
    List<String> affiliations,
    bool isGroup,
    bool isCheckForDepth,
    int depth,
    this.searchQueries,
    this.isCheckUniversalName,
    this.isCheckUniversalId,
    this.isCheckSocialName,
    this.isCheckCustomKeywords,
  }) : super(
          page: page,
          pageSize: pageSize,
          maxPages: maxPages,
          isHidden: isHidden,
          isCheckForAffiliations: isCheckForAffiliations,
          affiliations: affiliations,
          isGroup: isGroup,
          isCheckForDepth: isCheckForDepth,
          depth: depth,
        );

  final List<String> searchQueries;
  final bool isCheckUniversalName;
  final bool isCheckUniversalId;
  final bool isCheckSocialName;
  final bool isCheckCustomKeywords;

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> superMap = super.toJson();
    superMap.addAll({
      'searchQueries': searchQueries,
      'isCheckUniversalName': isCheckUniversalName,
      'isCheckUniversalId': isCheckUniversalId,
      'isCheckSocialName': isCheckSocialName,
      'isCheckCustomKeywords': isCheckCustomKeywords,
    });
    return superMap;
  }
}
