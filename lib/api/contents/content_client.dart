import 'package:flutter/foundation.dart';
import 'creator/creator_client.dart';
import 'video/video_client.dart';

export 'creator/creator_client.dart';
export 'video/video_client.dart';
export 'platform.dart';
export 'social.dart';
export 'content.dart';

class ContentClient {
  ContentClient({
    @required String domain,
    CreatorClient creatorClient,
    VideoClient videoClient,
  })  : assert(domain.isNotEmpty),
        creators = creatorClient ?? CreatorClient(domain: domain),
        videos = videoClient ?? VideoClient(domain: domain);

  final CreatorClient creators;
  final VideoClient videos;
}
