import 'package:erp_app/bloc/bloc.dart';
import 'package:get_it/get_it.dart';

class BlocDependencies {
  static void init(GetIt injector) {
    injector.registerLazySingleton<LoginBloc>(() => LoginBloc());
  }
}
