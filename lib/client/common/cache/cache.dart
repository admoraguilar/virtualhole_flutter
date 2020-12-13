/// TODO: Do something like interceptors where you can wrap
/// a call and have it cached.
/// var data = cache(() => http.get('google.com'), lifetime: Duration(days: 1));
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
