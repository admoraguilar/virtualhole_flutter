import 'cache.dart';

class SimpleCache<T> extends Cache<T> {
  Map<String, T> _map = {};

  @override
  T getOrUpsert(String key, T Function() dataFactory) {
    T data = get(key);
    if (data == null) {
      data = dataFactory();
      upsert(key, data);
    }
    return data;
  }

  @override
  bool contains(String key) {
    return _map.containsKey(key);
  }

  @override
  T get(String key) {
    return _map[key];
  }

  @override
  void upsert(String key, T data) {
    _map[key] = data;
  }

  @override
  void remove(String key) {
    _map.remove(key);
  }
}
