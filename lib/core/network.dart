import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class Network {
  Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://erp.ebst.tech',
      connectTimeout: 5000,
      receiveTimeout: 3000,
    ),
  );

  void setHeader() {
    dio.options.headers['X-Frappe-CSRF-Token'] =
        '60dd7f67e5def632917d750abf936393f0b35949898be23b71da412c';
    dio.options.headers['Cookie'] =
        'user_image=; sid=e80c4714b8ca041c83a6f8ecc98c0867a5e3437e2629e8ed921fbb48; system_user=yes; full_name=Doan%20Thinh; user_id=thinh.doan%40ebst.tech; io=LDkLFIes1ZyfAHh7AACK';
  }

  Future<CookieJar> getCookieJar() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    var cookieJar = PersistCookieJar(
      ignoreExpires: true,
      storage: FileStorage(appDocPath + "/.cookies/"),
    );
    return cookieJar;
  }
}
