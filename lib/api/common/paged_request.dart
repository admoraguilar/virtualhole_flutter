abstract class PagedRequest {
  const PagedRequest({
    this.batchSize,
    this.resultsLimit,
    this.skip,
  });

  final int batchSize;
  final int resultsLimit;
  final int skip;

  Map<String, dynamic> toJson() => {
        'batchSize': batchSize,
        'resultsLimit': resultsLimit,
        'skip': skip,
      };
}
