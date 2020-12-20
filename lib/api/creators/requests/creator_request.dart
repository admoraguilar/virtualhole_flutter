import 'package:virtualhole_flutter/api/api.dart';

class CreatorRequest extends PagedRequest {
  const CreatorRequest({
    DateTime timestamp,
    String locale,
    int page,
    int pageSize,
    int maxPages,
    this.search,
  }) : super(
          timestamp: timestamp,
          locale: locale,
          page: page,
          pageSize: pageSize,
          maxPages: maxPages,
        );

  final String search;

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> superMap = super.toJson();
    superMap.addAll({
      'search': search,
    });
    return superMap;
  }
}
