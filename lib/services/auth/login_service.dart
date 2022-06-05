import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:erp_app/constants.dart';
import 'package:erp_app/core/network.dart';
import 'package:erp_app/model/auth/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginService extends Network {
  Future<LoginResponse> login(LoginRequest request) async {
    try {
      final response = await dio.request(
        '/api/method/frappe.auth.login',
        data: FormData.fromMap(
          request.toMap(),
        ),
        options: Options(
          method: 'POST',
        ),
      );

      if (response.statusCode == 200) {
        final List<String>? listCookies = response.headers['Set-Cookie'];
        final List<String>? listAuthenticate = listCookies?[0].split(';');
        final String? sid = listAuthenticate?[0].split('=').last;
        final DateTime? expiredDate = DateFormat('E, dd-MMM-yyyy hh:mm:ss')
            .parse(listAuthenticate?[1].split('=').last ?? '');
        final String? fullName = Uri.decodeFull(response.data?['full_name']);
        final String? userId = Uri.decodeFull(
            listCookies?[3].split(';').first.split('=').last ?? '');
        final String? userImage =
            listCookies?[4].split(';').first.split('=').last;
        final String apiKey = response.data?['data']['api_key'];
        final String apiSecret = response.data?['data']['api_secret'];

        if (sid != null) {
          await _storeData(
              sid, expiredDate, fullName, userId, userImage, apiKey, apiSecret);
          return LoginResponse(isSuccess: true);
        } else {
          return LoginResponse(
            isSuccess: true,
            errorMessage: tr('login_failed'),
          );
        }
      } else {
        return LoginResponse(
            isSuccess: false, errorMessage: tr('login_failed'));
      }
    } catch (e) {
      print(e);
      return LoginResponse(isSuccess: false, errorMessage: tr('login_failed'));
    }
  }

  Future<void> logout() async {
    final SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    _sharedPreferences.remove(UserInfoField.sid);
    _sharedPreferences.remove(UserInfoField.expiredDate);
    _sharedPreferences.remove(UserInfoField.userId);
    _sharedPreferences.remove(UserInfoField.userImage);
    _sharedPreferences.remove(UserInfoField.fullName);
  }

  Future<void> _storeData(
    String sid,
    DateTime? expiredDate,
    String? fullName,
    String? userId,
    String? userImage,
    String apiKey,
    String apiSecret,
  ) async {
    final SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    await _sharedPreferences.setString(
      UserInfoField.sid,
      sid,
    );
    await _sharedPreferences.setString(
      UserInfoField.expiredDate,
      expiredDate.toString(),
    );
    await _sharedPreferences.setString(
      UserInfoField.fullName,
      fullName ?? '',
    );
    await _sharedPreferences.setString(
      UserInfoField.userId,
      userId ?? '',
    );
    await _sharedPreferences.setString(
      UserInfoField.userImage,
      userImage ?? '',
    );
    await _sharedPreferences.setString(UserInfoField.apiKey, apiKey);
    await _sharedPreferences.setString(UserInfoField.apiSecret, apiSecret);
  }
}
