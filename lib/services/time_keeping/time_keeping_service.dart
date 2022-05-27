import 'dart:convert';
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:erp_app/core/network.dart';
import 'package:erp_app/model/time_keeping/get_histories.dart';
import 'package:http/http.dart' as http;

class TimeKeepingService extends Network {
  Future<GetHistoriesResponse> getHistories(GetHistoriesRequest request) async {
    // List<Cookie> cookies = [
    //   Cookie(
    //     'user_image',
    //     '',
    //   ),
    //   Cookie(
    //     'sid',
    //     'e80c4714b8ca041c83a6f8ecc98c0867a5e3437e2629e8ed921fbb48',
    //   ),
    //   Cookie('system_user', 'yes'),
    //   Cookie('full_name', 'Doan%20Thinh'),
    //   Cookie('user_id', 'thinh.doan%40ebst.tech'),
    //   Cookie('io', 'LDkLFIes1ZyfAHh7AACK'),
    // ];

    // CookieJar cookieJar = CookieJar();
    // await cookieJar.saveFromResponse(Uri(), cookies);

    // dio.interceptors.add(CookieManager(cookieJar));
    try {
      final response = await http.post(
          Uri.parse(
              'https://erp.ebst.tech/api/method/frappe.desk.reportview.get'),
          body: request.toMap(),
          headers: {
            'Cookie':
                'user_image=; sid=fac2cee4d186b6fe29968a8bc050de1c001a8b021862a00f709a08cb; system_user=yes; full_name=Doan%20Thinh; user_id=thinh.doan%40ebst.tech; io=ABwQzjUyye3MXpJSAALI',
            'X-Frappe-CSRF-Token':
                '403801ba36f8b44074743684f28cef9fd93f2e40cc86860068228a4d',
            "Access-Control-Allow-Origin": "*",
            "Access-Control-Allow-Methods":
                "POST, GET, OPTIONS, PUT, DELETE, HEAD",
          });

      // final response = await dio.post(
      //   '/api/method/frappe.desk.reportview.get',
      //   data: FormData.fromMap(
      //     request.toMap(),
      //   ),
      //   options: Options(
      //     method: 'POST',
      //     headers: {
      //       'X-Frappe-CSRF-Token':
      //           '60dd7f67e5def632917d750abf936393f0b35949898be23b71da412c',
      //     },
      //     validateStatus: (status) {
      //       return (status ?? 200) < 600;
      //     },
      //   ),
      // );
      if (response.statusCode == 200) {
        return GetHistoriesResponse.fromJson(jsonDecode(response.body));
      } else {
        return GetHistoriesResponse(
          listTimeKeeping: [],
          isSuccess: false,
        );
      }
    } catch (e) {
      return GetHistoriesResponse(listTimeKeeping: [], isSuccess: false);
    }
  }
}
