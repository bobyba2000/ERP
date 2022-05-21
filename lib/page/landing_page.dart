import 'package:erp_app/page/authentication/login_page.dart';
import 'package:erp_app/page/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  Future<String?> getToken() async {
    SharedPreferences _sharePreferences = await SharedPreferences.getInstance();
    final token = _sharePreferences.getString('authToken');
    return token;
  }

  @override
  Widget build(BuildContext context) {
    EasyLoading.instance.maskType = EasyLoadingMaskType.black;
    return FutureBuilder<String?>(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const InitPage();
        }
        if (snapshot.hasData) {
          if (snapshot.data == null) {
            return const LoginPage();
          } else {
            return const MainPage();
          }
        }
        return const LoginPage();
      },
      future: getToken(),
    );
  }
}

class InitPage extends StatelessWidget {
  const InitPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('images/logo.png', width: 300, fit: BoxFit.fitWidth),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
    );
  }
}
