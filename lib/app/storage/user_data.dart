class UserData {
  static UserData fromJsonDecode(dynamic jsonDecode) {
    return UserData.fromJson(jsonDecode);
  }

  UserData({List<String> followedCreatorIds})
      : followedCreatorIds = followedCreatorIds ?? [];

  List<String> followedCreatorIds = [];

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      followedCreatorIds: List<String>.from(json['followedCreatorIds']),
    );
  }

  Map<String, dynamic> toJson() => {
        'followedCreatorIds': followedCreatorIds,
      };
}
