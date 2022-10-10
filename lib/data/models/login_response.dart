class LoginResponse {
  LoginResponse({
    required this.message,
    required this.accessToken,
    required this.userId,
    required this.name,
    required this.tokenType,
    required this.uuid,
    required this.expiresIn,
    required this.referalStatus,
  });
  late final String message;
  late final String accessToken;
  late final int userId;
  late final String name;
  late final String tokenType;
  late final String uuid;
  late final int expiresIn;
  late final String referalStatus;

  LoginResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    accessToken = json['access_token'];
    userId = json['user_id'];
    name = json['name'];
    tokenType = json['token_type'];
    uuid = json['uuid'];
    expiresIn = json['expires_in'];
    referalStatus = json['referal_status'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['message'] = message;
    data['access_token'] = accessToken;
    data['user_id'] = userId;
    data['name'] = name;
    data['token_type'] = tokenType;
    data['uuid'] = uuid;
    data['expires_in'] = expiresIn;
    data['referal_status'] = referalStatus;
    return data;
  }
}
