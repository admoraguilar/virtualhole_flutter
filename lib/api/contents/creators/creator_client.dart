import 'dart:convert';
import 'package:virtualhole_flutter/api/common/api_client.dart';
import 'creator.dart';
import 'requests/list_creators_request.dart';
import 'requests/list_creators_regex_request.dart';
import 'requests/list_creators_strict_request.dart';

export 'creator.dart';
export 'requests/list_creators_request.dart';
export 'requests/list_creators_regex_request.dart';
export 'requests/list_creators_strict_request.dart';

class CreatorsClient extends APIClient {
  CreatorsClient({String domain})
      : assert(domain.isNotEmpty),
        super(domain: domain);

  @override
  String get path => 'Creators';

  @override
  String get version => 'api';

  Future<List<Creator>> listCreatorsAsync<T extends ListCreatorsRequest>(
      T request) async {
    String slug = '';
    if (request is ListCreatorsRegexRequest) {
      slug = 'ListCreatorsRegex';
    } else if (request is ListCreatorsStrictRequest) {
      slug = 'ListCreatorsStrict';
    } else {
      slug = 'ListCreators';
    }

    return Creator.fromJsonDecode(
        await postAsync(createUri(slug), json.encode(request)));
  }
}
