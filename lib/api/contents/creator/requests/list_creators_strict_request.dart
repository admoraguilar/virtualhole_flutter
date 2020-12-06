import 'package:virtualhole_flutter/api/contents/creator/requests/list_creators_request.dart';

class ListCreatorsStrictRequest extends ListCreatorsRequest {
  const ListCreatorsStrictRequest({
    int batchSize,
    int resultsLimit,
    int skip,
    bool isHidden,
    bool isCheckForAffiliations,
    List<String> affiliations,
    bool isGroup,
    bool isCheckForDepth,
    int depth,
    this.isAll,
    this.universalName,
    this.universalId,
  }) : super(
          batchSize: batchSize,
          resultsLimit: resultsLimit,
          skip: skip,
          isHidden: isHidden,
          isCheckForAffiliations: isCheckForAffiliations,
          affiliations: affiliations,
          isGroup: isGroup,
          isCheckForDepth: isCheckForDepth,
          depth: depth,
        );

  final bool isAll;
  final String universalName;
  final String universalId;

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> superMap = super.toJson();
    superMap.addAll({
      'isAll': isAll,
      'universalName': universalName,
      'universalId': universalId,
    });
    return superMap;
  }
}
