import '../../virtualhole_api_client_dart.dart';

extension ContentExtensions on Content {
  String get thumbnailUrl {
    if (socialType == SocialType.youtube) {
      if (contentType == ContentType.video) {
        return (this as YouTubeVideo).thumbnailUrl;
      } else if (contentType == ContentType.broadcast) {
        return (this as YouTubeBroadcast).thumbnailUrl;
      }
    }

    throw Exception(
        '[${(Content)}] Thumbnail is unsupported for this content type.');
  }
}
