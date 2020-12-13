import 'package:virtualhole_flutter/api/common/paged_request.dart';
import 'package:virtualhole_flutter/api/contents/videos/requests/sort_mode.dart';

class ListVideosRequest extends PagedRequest {
  const ListVideosRequest({
    int page,
    int pageSize,
    int maxPages,
    this.sortMode,
    this.isSortAscending,
  }) : super(
          page: page,
          pageSize: pageSize,
          maxPages: maxPages,
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
