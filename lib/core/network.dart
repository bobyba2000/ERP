import 'package:dio/dio.dart';

class Network {
  Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://erp.ebst.tech',
      connectTimeout: 5000,
      receiveTimeout: 3000,
    ),
  );
}
