import 'package:virtualhole_flutter/api/common/paged_request.dart';
import 'package:virtualhole_flutter/api/contents/video/requests/sort_mode.dart';

class ListVideosRequest extends PagedRequest {
  const ListVideosRequest({
    this.sortMode,
    this.isSortAscending,
  });

  final SortMode sortMode;
  final bool isSortAscending;

  @override
  Map<String, dynamic> toJson() => {
        'sortMode': sortMode,
        'isSortAscending': isSortAscending,
      };
}
