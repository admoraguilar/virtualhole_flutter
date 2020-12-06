import 'dart:convert';

abstract class PagedRequest {
  const PagedRequest({
    this.batchSize,
    this.resultsLimit,
    this.skip,
  });

  final int batchSize;
  final int resultsLimit;
  final int skip;

  String toJsonEncode() {
    return json.encode(toJson);
  }

  Map<String, dynamic> toJson();
}
