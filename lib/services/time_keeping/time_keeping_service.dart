import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:erp_app/core/network.dart';
import 'package:erp_app/model/time_keeping/checkin.dart';
import 'package:erp_app/model/time_keeping/get_histories.dart';
import 'package:http/http.dart' as http;

class TimeKeepingService extends Network {
  Future<GetHistoriesResponse> getHistories(GetHistoriesRequest request) async {
    try {
      await setHeader();
      final response = await dio.request(
        '/api/method/frappe.desk.reportview.get',
        data: FormData.fromMap(request.toMap()),
        options: Options(
          method: 'POST',
        ),
      );
      if (response.statusCode == 200) {
        return GetHistoriesResponse.fromJson(response.data);
      } else {
        return GetHistoriesResponse(
          listTimeKeeping: [],
          isSuccess: false,
        );
      }
    } catch (e) {
      print(e);
      return GetHistoriesResponse(listTimeKeeping: [], isSuccess: false);
    }
  }

  Future<bool> checkin(CheckinRequest request) async {
    try {
      await setHeader();
      final response = await dio.request(
        '/api/method/frappe.desk.form.save.savedocs',
        data: FormData.fromMap(request.toMap()),
        options: Options(
          method: 'POST',
        ),
      );
      // final response = await http.post(
      //     Uri.parse(
      //         'https://erp.ebst.tech/api/method/frappe.desk.form.save.savedocs'),
      //     body: request.toMap(),
      //     headers: {
      //       'Cookie':
      //           'user_image=; sid=a37f4fd45315bed0a7947f8e58d09a09af5c9a91b1191d6e4f2714f9; system_user=yes; full_name=Doan%20Thinh; user_id=thinh.doan%40ebst.tech; io=Q59p-9goCw2BAuCzAA8a',
      //       'X-Frappe-CSRF-Token':
      //           'c61e6b6d379ff2fa00091540f48539a2b57960126df506ac0b139fbd',
      //       "Access-Control-Allow-Origin": "*",
      //       "Access-Control-Allow-Methods":
      //           "POST, GET, OPTIONS, PUT, DELETE, HEAD",
      //     });
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }
}
