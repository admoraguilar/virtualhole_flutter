import 'package:virtualhole_flutter/api/contents/creator/requests/list_creators_request.dart';

class ListCreatorsRegexRequest extends ListCreatorsRequest {
  const ListCreatorsRegexRequest({
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
