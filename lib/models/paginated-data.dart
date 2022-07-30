class PaginatedData<T> {
  final int page;
  final Iterable<T> data;
  final int totalPages;
  final int totalResults;

  PaginatedData(
      {required this.page,
      required this.data,
      required this.totalPages,
      required this.totalResults});
}
