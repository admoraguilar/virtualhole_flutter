import 'package:flutter/foundation.dart';
import 'creators/creator_client.dart';
import 'videos/video_client.dart';

export 'creators/creator_client.dart';
export 'videos/video_client.dart';
export 'platform.dart';
export 'social.dart';
export 'content.dart';

class ContentClient {
  ContentClient({
    @required String domain,
    CreatorsClient creatorClient,
    VideoClient videoClient,
  })  : assert(domain.isNotEmpty),
        creators = creatorClient ?? CreatorsClient(domain: domain),
        videos = videoClient ?? VideoClient(domain: domain);

  final CreatorsClient creators;
  final VideoClient videos;
}
