import 'package:virtualhole_flutter/api/common/paged_request.dart';
import 'package:virtualhole_flutter/api/contents/video/requests/sort_mode.dart';

class ListVideosRequest extends PagedRequest {
  const ListVideosRequest({
    int batchSize,
    int resultsLimit,
    int skip,
    this.sortMode,
    this.isSortAscending,
  }) : super(
          batchSize: batchSize,
          resultsLimit: resultsLimit,
          skip: skip,
        );

  final SortMode sortMode;
  final bool isSortAscending;

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> superMap = super.toJson();
    superMap.addAll({
      'sortMode': sortMode,
      'isSortAscending': isSortAscending,
    });
    return superMap;
  }
}
