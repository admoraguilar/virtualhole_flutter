import 'package:virtualhole_flutter/api/common/paged_request.dart';

class ListCreatorsRequest extends PagedRequest {
  const ListCreatorsRequest({
    int page,
    int pageSize,
    int maxPages,
    this.isHidden,
    this.isCheckForAffiliations,
    this.affiliations,
    this.isGroup,
    this.isCheckForDepth,
    this.depth,
  }) : super(
          page: page,
          pageSize: pageSize,
          maxPages: maxPages,
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
