import 'package:easy_localization/easy_localization.dart';
import 'package:erp_app/dependencies.dart';
import 'package:erp_app/page/landing_page.dart';
import 'package:erp_app/style/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppDependencies.initialize();
  runApp(
    EasyLocalization(
      path: 'assets/translations',
      supportedLocales: const [
        Locale('vi'),
        Locale('en'),
      ],
      startLocale: const Locale('vi'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: MyTheme.lightTheme(),
      home: const LandingPage(),
      builder: EasyLoading.init(),
    );
  }
}
