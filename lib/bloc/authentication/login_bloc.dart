import 'package:equatable/equatable.dart';
import 'package:erp_app/dependencies.dart';
import 'package:erp_app/services/auth/login_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoginState extends Equatable {
  final bool? isSuccess;
  final String? errorMessage;

  const LoginState({
    this.isSuccess,
    this.errorMessage,
  });
  @override
  List<Object?> get props => [isSuccess, errorMessage];

  LoginState copyWith({bool? isSuccess, String? errorMessage}) {
    return LoginState(
      isSuccess: isSuccess,
      errorMessage: errorMessage,
    );
  }
}

class LoginBloc extends Cubit<LoginState> {
  LoginService loginService = AppDependencies.injector<LoginService>();
  LoginBloc() : super(const LoginState());

  Future<void> login({
    required String userId,
    required String password,
  }) async {
    EasyLoading.show();
    final response = await loginService.login(LoginRequest(
      usr: userId,
      password: password,
    ));
    EasyLoading.dismiss();
    emit(
      state.copyWith(
        isSuccess: response.isSuccess,
        errorMessage: response.errorMessage,
      ),
    );
  }

  void resetState() {
    emit(const LoginState());
  }
}
