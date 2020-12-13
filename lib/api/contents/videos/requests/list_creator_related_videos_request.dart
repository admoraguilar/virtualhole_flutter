import 'package:virtualhole_flutter/api/contents/creators/creator.dart';
import 'package:virtualhole_flutter/api/contents/videos/requests/list_videos_request.dart';
import 'package:virtualhole_flutter/api/contents/videos/requests/sort_mode.dart';

class ListCreatorRelatedVideosRequest extends ListVideosRequest {
  const ListCreatorRelatedVideosRequest({
    int page,
    int pageSize,
    int maxPages,
    SortMode sortMode,
    bool isSortAscending,
    this.isBroadcast,
    this.isLive,
    this.creators,
  }) : super(
          page: page,
          pageSize: pageSize,
          maxPages: maxPages,
          sortMode: sortMode,
          isSortAscending: isSortAscending,
        );

  final bool isBroadcast;
  final bool isLive;
  final List<Creator> creators;

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> superMap = super.toJson();
    superMap.addAll({
      'isBroadcast': isBroadcast,
      'isLive': isLive,
      'creators': creators,
    });
    return superMap;
  }
}
