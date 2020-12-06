import 'package:virtualhole_flutter/api/contents/creator/creator.dart';
import 'package:virtualhole_flutter/api/contents/video/requests/list_videos_request.dart';
import 'package:virtualhole_flutter/api/contents/video/requests/sort_mode.dart';

class ListCreatorRelatedVideosRequest extends ListVideosRequest {
  const ListCreatorRelatedVideosRequest(
      {SortMode sortMode,
      bool isSortAscending,
      this.isBroadcast,
      this.isLive,
      this.creators})
      : super(
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
