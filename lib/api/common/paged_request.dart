import 'package:virtualhole_flutter/api/common/api_request.dart';

class PagedRequest extends APIRequest {
  const PagedRequest({
    DateTime timestamp,
    String locale,
    this.pageSize,
    this.maxPages,
    this.page,
  }) : super(
          timestamp: timestamp,
          locale: locale,
        );

  final int page;
  final int pageSize;
  final int maxPages;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = super.toJson();
    map.addAll({
      'page': page,
      'pageSize': pageSize,
      'maxPages': maxPages,
    });
    return map;
  }
}
