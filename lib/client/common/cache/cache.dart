abstract class Cache<T> {
  T getOrUpsert(
    String key,
    T Function() dataFactory,
  );
  bool contains(String key);
  T get(String key);
  void upsert(String key, T data);
  void remove(String key);
}
