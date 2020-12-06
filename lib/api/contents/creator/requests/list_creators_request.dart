import 'package:virtualhole_flutter/api/common/paged_request.dart';

class ListCreatorsRequest extends PagedRequest {
  const ListCreatorsRequest({
    int batchSize,
    int resultsLimit,
    int skip,
    this.isHidden,
    this.isCheckForAffiliations,
    this.affiliations,
    this.isGroup,
    this.isCheckForDepth,
    this.depth,
  }) : super(
          batchSize: batchSize,
          resultsLimit: resultsLimit,
          skip: skip,
        );

  final bool isHidden;
  final bool isCheckForAffiliations;
  final List<String> affiliations;
  final bool isGroup;
  final bool isCheckForDepth;
  final int depth;

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> superMap = super.toJson();
    superMap.addAll({
      'isHidden': isHidden,
      'isCheckForAffiliations': isCheckForAffiliations,
      'affiliations': affiliations,
      'isGroup': isGroup,
      'isCheckForDepth': isCheckForDepth,
      'depth': depth,
    });
    return superMap;
  }
}
