import 'package:virtualhole_flutter/api/common/paged_request.dart';

class ListCreatorsRequest extends PagedRequest {
  const ListCreatorsRequest({
    this.isHidden,
    this.isCheckForAffiliations,
    this.affiliations,
    this.isGroup,
    this.isCheckForDepth,
    this.depth,
  });

  final bool isHidden;
  final bool isCheckForAffiliations;
  final List<String> affiliations;
  final bool isGroup;
  final bool isCheckForDepth;
  final int depth;

  Map<String, dynamic> toJson() => {
        'isHidden': isHidden,
        'isCheckForAffiliations': isCheckForAffiliations,
        'affiliations': affiliations,
        'isGroup': isGroup,
        'isCheckForDepth': isCheckForDepth,
        'depth': depth,
      };
}
