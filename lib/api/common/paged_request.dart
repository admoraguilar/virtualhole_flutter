import 'package:virtualhole_flutter/api/api.dart';

abstract class PagedRequest extends APIRequest {
  const PagedRequest({
    String locale,
    int page,
    int pageSize,
    int maxPages,
  })  : this.page = page ?? 1,
        this.pageSize = pageSize ?? 20,
        this.maxPages = maxPages ?? 100,
        super(
          locale: locale,
        );

  final int page;
  final int pageSize;
  final int maxPages;

  @override
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
