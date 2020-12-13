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
}
