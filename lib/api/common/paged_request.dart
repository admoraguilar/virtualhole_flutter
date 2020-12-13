abstract class PagedRequest {
  const PagedRequest({
    this.pageSize,
    this.maxPages,
    this.page,
  });

  final int page;
  final int pageSize;
  final int maxPages;

  Map<String, dynamic> toJson() => {
        'page': page,
        'pageSize': pageSize,
        'maxPages': maxPages,
      };
}
