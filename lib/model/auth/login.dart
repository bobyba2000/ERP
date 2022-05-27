class LoginRequest {
  String usr;
  String password;
  String cmd = 'login';
  String device = 'mobile';

  LoginRequest({required this.usr, required this.password});

  Map<String, dynamic> toMap() {
    return {
      'usr': usr,
      'pwd': password,
      'cmd': cmd,
      'device': device,
    };
  }
}

class LoginResponse {
  bool isSuccess;
  String? errorMessage;
  LoginResponse({required this.isSuccess, this.errorMessage});
}
