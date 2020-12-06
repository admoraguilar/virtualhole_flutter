import 'package:virtualhole_flutter/api/common/api_client.dart';
import 'video.dart';
import 'broadcast.dart';
import 'requests/list_videos_request.dart';
import 'requests/list_creator_videos_request.dart';
import 'requests/list_creator_related_videos_request.dart';

export 'video.dart';
export 'broadcast.dart';
export 'requests/sort_mode.dart';
export 'requests/list_videos_request.dart';
export 'requests/list_creator_videos_request.dart';
export 'requests/list_creator_related_videos_request.dart';

class VideoClient extends APIClient {
  VideoClient({String domain})
      : assert(domain.isNotEmpty),
        super(domain: domain);

  @override
  String get path => 'Videos';

  @override
  String get version => 'api';

  Future<List<TVideo>>
      listVideosAsync<TVideo, TRequest extends ListVideosRequest>(
          TRequest request) async {
    String slug = '';
    if (request is ListCreatorRelatedVideosRequest) {
      if (TVideo is Broadcast) {
        slug = 'ListCreatorRelatedBroadcast';
      } else {
        slug = 'ListCreatorRelatedVideos';
      }
    } else if (request is ListCreatorVideosRequest) {
      if (TVideo is Broadcast) {
        slug = 'ListCreatorBroadcast';
      } else {
        slug = 'ListCreatorVideos';
      }
    } else {
      throw UnsupportedError('Video Client request not supported.');
    }

    if (TVideo is Broadcast) {
      Broadcast.fromJsonDecode(
          await postAsync(createUri(slug), request.toJsonEncode()));
    } else {
      Video.fromJsonDecode(
          await postAsync(createUri(slug), request.toJsonEncode()));
    }
  }
}
