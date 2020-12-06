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
  final isCheckForDepth;
  final int depth;
}
