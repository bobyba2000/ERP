import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:erp_app/core/network.dart';

class FileService extends Network {
  Future<bool> uploadFile(XFile file, String docname) async {
    String fileName = file.path.split('/').last;

    FormData data = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      ),
      'is_private': 0,
      'folder': 'Home',
      'doctype': 'Employee Checkin',
      'docname': docname,
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
      //   final request = http.MultipartRequest(
      //       "POST", Uri.parse('https://erp.ebst.tech/api/method/upload_file'))
      //     ..fields['folder'] = 'Home'
      //     ..fields['doctype'] = 'Employee Checkin'
      //     ..fields['docname'] = docname
      //     ..fields['fieldname'] = 'image'
      //     ..files.add(
      //       MultipartFile.fromBytes(
      //         'file',
      //         bytes,
      //         filename: DateTime.now().toString(),
      //       ),
      //     )
      //     ..headers['Cookie'] =
      //         'user_image=; system_user=yes; full_name=Doan%20Thinh; user_id=thinh.doan%40ebst.tech; sid=1b861f76b468acfb378869ac55a11794d2cd607c9842c952e270ece9; io=rDVpWtd8WVSUT0TeAA8d'
      //     ..headers['X-Frappe-CSRF-Token'] =
      //         'c61e6b6d379ff2fa00091540f48539a2b57960126df506ac0b139fbd';

      //   print(request.files);
      //   final response = await request.send();
      //   print(request.fields);
      // final response = await http.post(
      //   Uri.parse('https://erp.ebst.tech/api/method/upload_file'),
      //   body: request,
      //   headers: {
      //     'Cookie':
      //         'user_image=; system_user=yes; full_name=Doan%20Thinh; user_id=thinh.doan%40ebst.tech; sid=1b861f76b468acfb378869ac55a11794d2cd607c9842c952e270ece9; io=rDVpWtd8WVSUT0TeAA8d',
      //     'X-Frappe-CSRF-Token':
      //         'c61e6b6d379ff2fa00091540f48539a2b57960126df506ac0b139fbd',
      //     "Access-Control-Allow-Origin": "*",
      //     "Access-Control-Allow-Methods":
      //         "POST, GET, OPTIONS, PUT, DELETE, HEAD",
      //   },
      // );
      // print(response.statusCode);
      // print(await response.stream.bytesToString());
      return response.statusCode == 200;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
