abstract class APIRequest {
  const APIRequest({
    this.timestamp,
    this.locale,
  });

  final DateTime timestamp;
  final String locale;

  Map<String, dynamic> toJson() {
    return {
      'timestamp': timestamp,
      'locale': locale,
    };
  }

  Map<String, String> toQueryMap() {
    Map<String, String> result = {};
    toJson().forEach((key, value) {
      if (value != null) {
        result.addAll({key: value.toJson()});
      }
    });
    return result;
  }
}
