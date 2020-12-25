import '../../virtualhole_api_client_dart.dart';

class CreatorRequest extends PagedRequest {
  const CreatorRequest({
    DateTime timestamp,
    String locale,
    int page,
    int pageSize,
    int maxPages,
    this.search,
  }) : super(
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

  CreatorRequest copyWith({
    DateTime timestamp,
    String locale,
    int page,
    int pageSize,
    int maxPages,
    String search,
  }) {
    return CreatorRequest(
      timestamp: timestamp ?? this.timestamp,
      locale: locale ?? this.locale,
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
      maxPages: maxPages ?? this.maxPages,
      search: search ?? this.search,
    );
  }
}
