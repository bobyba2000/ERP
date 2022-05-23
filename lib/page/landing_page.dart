import 'package:easy_localization/easy_localization.dart';
import 'package:erp_app/constants.dart';
import 'package:erp_app/dependencies.dart';
import 'package:erp_app/page/authentication/login_page.dart';
import 'package:erp_app/page/main_page.dart';
import 'package:erp_app/preference/user_preference.dart';
import 'package:erp_app/services/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  Future<String?> getToken() async {
    SharedPreferences _sharePreferences = await SharedPreferences.getInstance();
    final token = _sharePreferences.getString(UserInfoField.sid);
    if (token == null) {
      return null;
    } else {
      final String? expiredDateString =
          _sharePreferences.getString(UserInfoField.expiredDate);
      if (expiredDateString != null) {
        DateTime expiredDate = DateTime.parse(expiredDateString);
        if (expiredDate.compareTo(DateTime.now()) > 0) {
          UserPreference _userPreference =
              AppDependencies.injector<UserPreference>();
          _userPreference.fullName =
              _sharePreferences.getString(UserInfoField.fullName);
          _userPreference.userId =
              _sharePreferences.getString(UserInfoField.userId);
          _userPreference.userImage =
              _sharePreferences.getString(UserInfoField.userImage);
          return token;
        } else {
          final LoginService _service =
              AppDependencies.injector<LoginService>();
          await _service.logout();
          return null;
        }
      } else {
        final LoginService _service = AppDependencies.injector<LoginService>();
        await _service.logout();
        return null;
      }
    }
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
