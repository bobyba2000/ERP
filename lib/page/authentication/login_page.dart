import 'package:easy_localization/easy_localization.dart';
import 'package:erp_app/bloc/authentication/login_bloc.dart';
import 'package:erp_app/common_widget/text_field_widget.dart';
import 'package:erp_app/dependencies.dart';
import 'package:erp_app/page/landing_page.dart';
import 'package:erp_app/utils/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class _CurvedPainterTop extends CustomPainter {
  final Color color;
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = color
      ..strokeWidth = 15;
    var path = Path();
    path.moveTo(0, size.height * 0.4);
    path.quadraticBezierTo(-size.width * 0.25, -size.height * 0.1,
        size.width * 0.5, size.height * 0.1);
    path.quadraticBezierTo(size.width * 1.25, size.height * 0.3, size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  _CurvedPainterTop({required this.color});
}

class _CurvedPainterBottom extends CustomPainter {
  final Color color;
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = color
      ..strokeWidth = 15;
    var path = Path();
    path.moveTo(0, size.height * 0.4);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.4,
        size.width * 0.5, size.height * 0.6);
    path.quadraticBezierTo(
        size.width * 0.75, size.height * 0.80, size.width, size.height * 0.8);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  _CurvedPainterBottom({required this.color});
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController userIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  LoginBloc bloc = AppDependencies.injector<LoginBloc>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<LoginBloc>(
        create: (context) => bloc,
        child: BlocConsumer<LoginBloc, LoginState>(
          builder: (context, state) {
            return buildScreen(context);
          },
          listener: (context, state) {
            if (state.isSuccess == true) {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const LandingPage(),
                ),
                (route) => false,
              );
            }
            if (state.isSuccess == false) {
              ToastUtils.showToast(
                msg: state.errorMessage ?? '',
                isError: true,
              );
              bloc.resetState();
            }
          },
        ),
      ),
    );
  }

  Widget buildScreen(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                theme.secondaryHeaderColor,
                theme.primaryColor,
              ],
            ),
          ),
          child: CustomPaint(
            size: const Size(double.infinity, 200),
            painter: _CurvedPainterTop(color: theme.backgroundColor),
          ),
        ),
        CustomPaint(
          size: const Size(double.infinity, 200),
          painter: _CurvedPainterBottom(color: theme.primaryColor),
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              Image.asset('images/logo.png', width: 300, fit: BoxFit.fitWidth),
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFieldWidget(
                      controller: userIdController,
                      label: tr('email'),
                      hintText: tr('email_hint'),
                    ),
                    const SizedBox(height: 16),
                    TextFieldWidget(
                      controller: passwordController,
                      label: tr('password'),
                      hintText: tr('password_hint'),
                      isPassword: true,
                    ),
                    const SizedBox(height: 24),
                    GestureDetector(
                      onTap: () async {
                        bloc.login(
                          userId: userIdController.text,
                          password: passwordController.text,
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: theme.primaryColor,
                        ),
                        child: Text(
                          tr('login'),
                          style: theme.textTheme.button,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
