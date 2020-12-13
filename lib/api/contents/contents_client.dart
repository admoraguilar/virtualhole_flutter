import 'package:virtualhole_flutter/api/common/api_client.dart';
import 'package:virtualhole_flutter/api/contents/content.dart';
import 'package:virtualhole_flutter/api/contents/request/content_query.dart';
export 'content.dart';

class ContentsClient extends APIClient {
  ContentsClient({String domain})
      : assert(domain.isNotEmpty),
        super(domain: domain);

  @override
  String get version => 'api/v1';

  @override
  String get path => 'contents';

  Future<List<Content>> get(ContentQuery query) async {
    String path = '';
    return Content.fromJsonDecode(await getAsync(createUri(path)));
  }
}
