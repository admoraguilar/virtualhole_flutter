import 'package:virtualhole_flutter/api/common/api_client.dart';
import 'package:virtualhole_flutter/api/contents/content.dart';
import 'package:virtualhole_flutter/api/contents/request/content_request.dart';
export 'content.dart';

class ContentsClient extends APIClient {
  ContentsClient({String domain})
      : assert(domain.isNotEmpty),
        super(domain: domain);

  @override
  String get version => 'api/v1';

  @override
  String get rootPath => 'contents';

  Future<List<Content>> get(ContentRequest query) async {
    String path = '';
    return Content.fromJsonDecode(await getAsync(createUri(path)));
  }
}
