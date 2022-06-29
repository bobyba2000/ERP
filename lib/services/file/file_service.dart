import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:erp_app/core/network.dart';

class FileService extends Network {
  Future<String?> uploadFile(XFile file, String docname) async {
    String fileName = file.path.split('/').last;

    FormData data = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      ),
      'is_private': 0,
      'folder': 'Home',
      'doctype': 'Employee Checkin',
      // 'docname': docname,
      'fieldname': 'image',
    });

    try {
      await setHeader();
      final response = await dio.request(
        '/api/method/upload_file',
        data: data,
        options: Options(
          method: 'POST',
        ),
      );
      final json = response.data;

      return json['message']['file_url'];
    } catch (e) {
      print(e);
      return null;
    }
  }
}
