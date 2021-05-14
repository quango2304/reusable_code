mixin PaginationHelper<T> {
  List<T?> items = [];

  bool get isLoading;

  bool get isFirstLoad => isLoading && items.isEmpty;

  bool get canLoadMore;

  Future<void> loadMore();

  void reset();

  int get limit => 14;

  Future<void> refresh();
}
