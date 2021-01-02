abstract class ApiRequest {
  const ApiRequest({
    String locale,
  }) : this.locale = locale ?? 'en-US';

  final String locale;

  DateTime get timestamp => DateTime.now().toUtc();

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
        if (value is List) {
          result.addAll({key: value.join(',')});
        } else {
          result.addAll({key: value.toString()});
        }
      }
    });
    return result;
  }
}
