import 'package:dio/dio.dart';
import 'package:erp_app/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Network {
  Dio dio = Dio(
    BaseOptions(
        baseUrl: 'https://erp.ebst.tech',
        connectTimeout: 5000,
        receiveTimeout: 3000,
        validateStatus: (status) {
          return (status ?? 500) < 500;
        }),
  );

  Future<void> setHeader() async {
    final SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    String apiKey = _sharedPreferences.getString(UserInfoField.apiKey) ?? '';
    String apiSecret =
        _sharedPreferences.getString(UserInfoField.apiSecret) ?? '';
    dio.options.headers['Authorization'] = 'token $apiKey:$apiSecret';
  }
}
